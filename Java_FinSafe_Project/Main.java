import java.util.Scanner;

/**
 * Console front-end for FinSafe. All parsing happens here — Account stays dumb.
 */
public class Main {

    private static final String MENU = "1. Deposit\n2. Withdraw\n3. Balance\n4. Mini Statement\n5. Exit";

    public static void main(String[] args) {
        // try-with-resources so scanner closes — easy to forget in small assignments
        try (Scanner sc = new Scanner(System.in)) {

            System.out.println("=== FinSafe Wallet System ===");
            System.out.print("Enter your name: ");
            String name = sc.nextLine().trim();
            if (name.isEmpty()) {
                name = "Guest";
            }

            Account acc = new Account(name, 0.0);

            boolean running = true;
            while (running) {
                System.out.println();
                System.out.println(MENU);
                System.out.print("Choose option (1-5): ");

                String choice = sc.nextLine().trim();

                try {
                    switch (choice) {
                        case "1":
                            System.out.print("Enter amount to deposit: ");
                            double dep = parseMoney(sc.nextLine());
                            acc.deposit(dep);
                            System.out.println("OK. Balance now: Rs. " + acc.checkBalance());
                            break;
                        case "2":
                            System.out.print("Enter amount to withdraw: ");
                            double w = parseMoney(sc.nextLine());
                            acc.withdraw(w);
                            System.out.println("OK. Balance now: Rs. " + acc.checkBalance());
                            break;
                        case "3":
                            // quick balance — no extra formatting
                            System.out.println("Balance: Rs. " + acc.checkBalance());
                            break;
                        case "4":
                            acc.printMiniStatement();
                            break;
                        case "5":
                            System.out.println("Thank you for using FinSafe. Bye!");
                            running = false;
                            break;
                        default:
                            System.out.println("Invalid choice, try 1-5.");
                    }
                } catch (NumberFormatException ex) {
                    System.out.println("Please type a valid number.");
                } catch (IllegalArgumentException ex) {
                    System.out.println("Error: " + ex.getMessage());
                } catch (InsufficientFundsException ex) {
                    System.out.println("Error: " + ex.getMessage());
                }
            }
        }
    }

    /** Parses rupee amount; throws NumberFormatException if bad. */
    private static double parseMoney(String line) {
        return Double.parseDouble(line.trim());
    }
}
