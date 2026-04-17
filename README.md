# Virtusa Mini Project Collection

Hey — this repo is a small bundle of **three standalone projects** in **Python**, **Java**, and **SQL (MySQL)**. Each folder is its own thing: its own code and a short README inside, so you can jump straight to whatever you’re curious about.

I put this together for learning, demos, or coursework. Nothing here needs paid APIs or a cloud signup; you can run it all locally.

---

## What’s inside

```
Virtusa-mini-project/
├── Python_FareCalc_Project/     # Fare calculator CLI (surge pricing)
├── Java_FinSafe_Project/        # Console wallet (OOP + exceptions)
├── SQL_DigitalLibrary_Project/  # Library schema + sample queries (MySQL)
└── README.md                    # This file
```

---

## Before you start

| Project | What you need |
|--------|----------------|
| **Python** | [Python 3](https://www.python.org/downloads/) (3.8+ is fine) |
| **Java** | [JDK](https://adoptium.net/) 8 or newer (`javac` and `java` on your PATH) |
| **SQL** | [MySQL Server](https://dev.mysql.com/downloads/mysql/) (Workbench optional, for GUI) |

Install only what you plan to run — no need to clutter your machine with everything at once.

---

## 1. Python — FareCalc Travel Optimizer

**Folder:** `Python_FareCalc_Project/`

This one estimates a ride fare from **distance (km)**, **vehicle type** (Economy / Premium / SUV), and **hour of day** (0–23). There’s **evening surge** (1.5×) between **17:00 and 20:00**.

### Run

```bash
cd Python_FareCalc_Project
python main.py
```

On Windows, if `python` isn’t found, try `py main.py`.

More detail and sample I/O: see `Python_FareCalc_Project/README.md`.

---

## 2. Java — FinSafe Wallet System

**Folder:** `Java_FinSafe_Project/`

A **menu-driven** console app: deposit, withdraw, check balance, and a **mini statement** of the last five transactions. It uses **encapsulation**, a **custom exception** for insufficient funds, and **`IllegalArgumentException`** for invalid amounts.

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

A MySQL script that creates a **`digital_library`** database with tables for **books**, **students**, and **issued books**, loads sample data, and runs example queries (overdue books, popular category, inactive students, overdue penalty).

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

## Tips if you’re using GitHub

- If you build Java locally, a **`.gitignore`** helps (e.g. ignore `*.class`). For Python, people often ignore `__pycache__/`.
- There’s no shared build tool here (no Maven/Gradle/npm) on purpose — each subproject stays simple.
- If you re-run `library.sql` on the same server, drop or rename the old database first, or tweak the script so it doesn’t step on existing data.

---

## Contributors

**Sukrit Raj** — SRM Institute of Science and Technology (SRMIST)

This collection is maintained and contributed by Sukrit. If you fork or extend these projects, you’re welcome to add yourself here too.
