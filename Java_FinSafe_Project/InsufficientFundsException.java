// Thrown when withdraw > balance. Checked exception on purpose (caller must handle).

public class InsufficientFundsException extends Exception {

    private static final long serialVersionUID = 1L;

    public InsufficientFundsException(String msg) {
        super(msg);
    }
}
