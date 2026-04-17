-- Digital Library System (MySQL 5.7+ / 8.x)
-- Run in Workbench or: mysql -u user -p < library.sql
-- Charset: stick to utf8mb4 for names with special chars (future-proof)

SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS digital_library
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE digital_library;

-- ========== TABLES ==========
-- InnoDB = row locks + FK support (what you'd pick in "real" apps)

CREATE TABLE IF NOT EXISTS Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    category VARCHAR(100) NOT NULL,
    INDEX idx_books_category (category)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=soft-disabled',
    INDEX idx_students_active (is_active)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS IssuedBooks (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    student_id INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    INDEX idx_issued_dates (issue_date, return_date),
    INDEX idx_issued_student (student_id)
) ENGINE=InnoDB;

-- ========== SAMPLE DATA ==========
-- wrapped in transaction so either all sample rows load or none (cleaner for demos)

START TRANSACTION;

INSERT INTO Books (title, category) VALUES
('Python Basics', 'Programming'),
('Data Structures 101', 'Programming'),
('World History', 'History'),
('Indian Constitution', 'Law'),
('Organic Chemistry', 'Science');

INSERT INTO Students (name, is_active) VALUES
('Rahul Kumar', 1),
('Sneha Patel', 1),
('Amit Singh', 1),
('Old User One', 1);

INSERT INTO IssuedBooks (book_id, student_id, issue_date, return_date) VALUES
(1, 1, '2026-03-01', '2026-03-10'),
(2, 1, '2026-03-15', NULL),
(3, 2, '2026-02-01', '2026-02-20'),
(4, 2, '2025-11-01', NULL),
(5, 3, '2026-04-01', '2026-04-05'),
(4, 1, '2024-01-01', '2024-01-15');

COMMIT;
-- (if something failed above you'd ROLLBACK in manual runs)

-- ========== QUERY 1: Overdue (>14 days, still out) ==========
-- "as of today" — in reports we sometimes snapshot @as_of instead of CURDATE()

SET @as_of = CURDATE();

SELECT
    i.issue_id,
    b.title,
    s.name AS student_name,
    i.issue_date,
    DATEDIFF(@as_of, i.issue_date) AS days_since_issue
FROM IssuedBooks AS i
INNER JOIN Books AS b ON i.book_id = b.book_id
INNER JOIN Students AS s ON i.student_id = s.student_id
WHERE i.return_date IS NULL
  AND DATEDIFF(@as_of, i.issue_date) > 14;

-- ========== QUERY 2: Hottest category (COUNT + GROUP BY) ==========

SELECT b.category, COUNT(*) AS issue_count
FROM IssuedBooks AS i
INNER JOIN Books AS b ON i.book_id = b.book_id
GROUP BY b.category
ORDER BY issue_count DESC, b.category ASC
LIMIT 1;

-- ========== QUERY 3: Soft-disable stale students ==========
-- no issue in last 3 years -> mark inactive (business rule from librarian)

UPDATE Students AS s
SET s.is_active = 0
WHERE s.student_id NOT IN (
    SELECT DISTINCT student_id FROM IssuedBooks
    WHERE issue_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
);

SELECT student_id, name, is_active FROM Students;

-- ========== BONUS: Penalty (Rs 5 / day after grace) ==========
-- grace = 14 days; charge only on extra days

SELECT
    i.issue_id,
    b.title,
    s.name AS student_name,
    i.issue_date,
    DATEDIFF(CURDATE(), i.issue_date) AS days_out,
    GREATEST(0, DATEDIFF(CURDATE(), i.issue_date) - 14) AS billable_overdue_days,
    GREATEST(0, DATEDIFF(CURDATE(), i.issue_date) - 14) * 5 AS penalty_inr
FROM IssuedBooks AS i
INNER JOIN Books AS b ON i.book_id = b.book_id
INNER JOIN Students AS s ON i.student_id = s.student_id
WHERE i.return_date IS NULL
  AND DATEDIFF(CURDATE(), i.issue_date) > 14;
