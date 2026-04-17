import java.util.ArrayList;
import java.util.List;

/**
 * Basic wallet account — not thread-safe (fine for this console demo).
 * In production you'd sync methods or use a proper ledger DB.
 */
public class Account {

    private static final int MAX_HISTORY = 5;

    private double balance;
    private String accountHolder;
    // using interface type on the left — habit from code review
    private List<String> lastTransactions;

    public Account(String name, double startingBalance) {
        this.accountHolder = name;
        this.balance = startingBalance;
        this.lastTransactions = new ArrayList<String>();

        if (startingBalance > 0) {
            // opening line — same format as other lines mostly
            pushHistory(String.format("Opening balance: Rs. %.2f", startingBalance));
        }
    }

    public void deposit(double amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative.");
        }
        // edge case: zero deposit — still allowed, we just don't log noise
        if (amount == 0) {
            return;
        }
        balance = balance + amount;
        pushHistory("Deposited Rs. " + amount + " | Balance: Rs. " + balance);
    }

    public void withdraw(double amount) throws InsufficientFundsException {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative.");
        }
        if (amount > balance) {
            throw new InsufficientFundsException(
                "Not enough balance. You have Rs. " + balance);
        }
        balance = balance - amount;
        // sometimes we use format, sometimes concat — old code path
        pushHistory(String.format("Withdrew Rs. %.2f | Balance: Rs. %.2f", amount, balance));
    }

    public double checkBalance() {
        return balance;
    }

    public String getAccountHolder() {
        return accountHolder;
    }

    private void pushHistory(String line) {
        lastTransactions.add(line);
        while (lastTransactions.size() > MAX_HISTORY) {
            lastTransactions.remove(0);
        }
    }

    public void printMiniStatement() {
        System.out.println();
        System.out.println("--- Mini Statement (last " + MAX_HISTORY + ") ---");
        System.out.println("Account: " + accountHolder);
        if (lastTransactions.isEmpty()) {
            System.out.println("No transactions yet.");
        } else {
            int n = 1;
            for (String row : lastTransactions) {
                System.out.println(n + ". " + row);
                n++;
            }
        }
        System.out.println("Current balance: Rs. " + balance);
        System.out.println("--------------------------------");
    }
}
