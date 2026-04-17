# Digital Library System (SQL)

This folder has a **MySQL** script that creates a small **digital library**: books, students, and issued books. It also includes example **queries** for overdue books, popular category, and inactive students.

## Tables

| Table | What it stores |
|-------|----------------|
| **Books** | `book_id`, `title`, `category` |
| **Students** | `student_id`, `name`, `is_active` (1 = active, 0 = inactive) |
| **IssuedBooks** | `issue_id`, `book_id`, `student_id`, `issue_date`, `return_date` (`NULL` if not returned yet) |

## How to run

1. Install MySQL and open **MySQL Workbench** (or use command line).
2. Open `library.sql` and run the whole script, or:

```bash
mysql -u your_user -p < library.sql
```

3. Run queries one by one if you want to see each result clearly.

## Queries in the script

1. **Overdue books** — Books that are **not returned** and kept for **more than 14 days** since `issue_date` (compared to today’s date).

2. **Most popular category** — Counts how many times books from each category appear in `IssuedBooks`, then shows the top one.

3. **Inactive students** — Students with **no** book issue in the **last 3 years** get `is_active = 0`. (Adjust the rule in class if your teacher wants a different definition.)

4. **Bonus — Penalty** — For overdue not-returned books: **Rs 5 per day** only for days **after** the first 14 days. Example: 20 days out → 6 overdue days → Rs 30.

## Expected output (idea)

- Overdue list will show rows where `return_date` is `NULL` and days since issue > 14 (depends on **today’s date** when you run it).
- Popular category will show one row like: `Programming` with the highest count if that category has the most issues in sample data.
- After the UPDATE, students with no recent issues may show `is_active = 0`.
- Penalty query shows `penalty_rs` in rupees for each qualifying issue.

**Note:** Results that use `CURDATE()` change depending on **when** you run the script.
