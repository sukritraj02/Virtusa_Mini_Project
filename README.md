# Virtusa Mini Project Collection

This repository bundles **three small, standalone projects** in different technologies: **Python**, **Java**, and **SQL (MySQL)**. Each folder is self-contained with its own source files and a short README.

Use this repo for learning, demos, or coursework—nothing here requires paid services or cloud accounts.

---

## Repository layout

```
Virtusa-mini-project/
├── Python_FareCalc_Project/     # Fare calculator CLI (surge pricing)
├── Java_FinSafe_Project/        # Console wallet (OOP + exceptions)
├── SQL_DigitalLibrary_Project/  # Library schema + sample queries (MySQL)
└── README.md                    # This file
```

---

## Prerequisites

| Project | What you need |
|--------|----------------|
| **Python** | [Python 3](https://www.python.org/downloads/) (3.8+ is fine) |
| **Java** | [JDK](https://adoptium.net/) 8 or newer (`javac` and `java` on your PATH) |
| **SQL** | [MySQL Server](https://dev.mysql.com/downloads/mysql/) (Workbench optional, for GUI) |

Install only what you plan to run.

---

## 1. Python — FareCalc Travel Optimizer

**Folder:** `Python_FareCalc_Project/`

Estimates a ride fare from **distance (km)**, **vehicle type** (Economy / Premium / SUV), and **hour of day** (0–23). Applies **evening surge** (1.5×) between **17:00 and 20:00**.

### Run

```bash
cd Python_FareCalc_Project
python main.py
```

On Windows, if `python` is not found, try `py main.py`.

More detail and sample I/O: see `Python_FareCalc_Project/README.md`.

---

## 2. Java — FinSafe Wallet System

**Folder:** `Java_FinSafe_Project/`

A **menu-driven** console app: deposit, withdraw, check balance, and a **mini statement** of the last five transactions. Uses **encapsulation**, a **custom exception** for insufficient funds, and **`IllegalArgumentException`** for invalid amounts.

### Run

```bash
cd Java_FinSafe_Project
javac Main.java Account.java InsufficientFundsException.java
java Main
```

More detail: see `Java_FinSafe_Project/README.md`.

---

## 3. SQL — Digital Library System

**Folder:** `SQL_DigitalLibrary_Project/`

MySQL script that creates a **`digital_library`** database with tables for **books**, **students**, and **issued books**, loads sample data, and runs example queries (overdue books, popular category, inactive students, overdue penalty).

### Run (command line)

```bash
cd SQL_DigitalLibrary_Project
mysql -u YOUR_USER -p < library.sql
```

Replace `YOUR_USER` with your MySQL username; enter the password when prompted.

### Run (MySQL Workbench)

Open `library.sql`, connect to your server, and execute the script (e.g. lightning icon).

More detail: see `SQL_DigitalLibrary_Project/README.md`.

---

## Tips for GitHub

- Add a **`.gitignore`** if you use Java builds locally (ignore `*.class`). Python users often ignore `__pycache__/`.
- This repo has **no** shared build tool (no Maven/Gradle/npm); each subproject is intentionally simple.
- If you re-run `library.sql` on the same server, drop or rename the old database first, or adjust the script so it does not clash with existing data.

---

## License

No license is specified by default. If you need one for submission or open source, add a `LICENSE` file (e.g. MIT) in the repository root.
