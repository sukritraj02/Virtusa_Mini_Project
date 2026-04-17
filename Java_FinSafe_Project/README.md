# FinSafe Wallet System

A simple console program that acts like a **mini wallet**. You can put money in (**deposit**), take money out (**withdraw**), see your **balance**, and view a **mini statement** of the last few actions.

This project is for learning **basic Java OOP** and **exception handling**.

## Concepts used

- **Encapsulation**: `balance` and `accountHolder` are `private` in the `Account` class. Outside code uses methods like `deposit()` and `withdraw()` instead of changing balance directly.
- **Custom exception**: `InsufficientFundsException` is thrown when withdrawal is more than available balance.
- **Built-in exception**: `IllegalArgumentException` is used when someone enters a **negative** amount for deposit or withdraw.
- **Collections**: `ArrayList` stores the **last 5** transaction lines for the mini statement.

## How to run

You need Java installed (JDK 8 or newer is fine).

1. Open terminal in this folder (`Java_FinSafe_Project`).
2. Compile:

```bash
javac Main.java Account.java InsufficientFundsException.java
```

3. Run:

```bash
java Main
```

4. Use the menu: deposit some money, withdraw, check balance, print mini statement, then exit.

## Files

| File | Role |
|------|------|
| `Main.java` | Menu loop and user input |
| `Account.java` | Balance, deposits, withdrawals, last 5 transactions |
| `InsufficientFundsException.java` | Custom error for “not enough money” |
