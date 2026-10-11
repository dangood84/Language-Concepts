/*
 * Bank Account System in Java
 * Demonstrates full OOP: classes, inheritance, interfaces, abstract classes
 */

// ============================================================
// INTERFACE - ABSTRACTION
// ============================================================

interface Transferable {
    void transfer(Account destination, double amount);
}

// ============================================================
// ABSTRACT BASE ACCOUNT CLASS
// ============================================================

abstract class Account {
    protected String accountNumber;
    protected String ownerName;
    protected double balance;

    // Constructor
    public Account(String accountNumber, String ownerName, double initialBalance) {
        this.accountNumber = accountNumber;
        this.ownerName = ownerName;
        this.balance = initialBalance;
        System.out.println("✓ Account created: " + accountNumber + " for " + ownerName);
    }

    // Concrete methods
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            System.out.printf("✓ Deposited $%.2f. New balance: $%.2f%n", amount, balance);
        } else {
            System.out.println("❌ Invalid deposit amount");
        }
    }

    // Abstract method (must be implemented by subclasses)
    public abstract void withdraw(double amount);

    public void display() {
        System.out.println("\n=== Account Details ===");
        System.out.println("Account Number: " + accountNumber);
        System.out.println("Owner: " + ownerName);
        System.out.printf("Balance: $%.2f%n", balance);
    }

    // Getters (encapsulation)
    public String getAccountNumber() { return accountNumber; }
    public String getOwnerName() { return ownerName; }
    public double getBalance() { return balance; }

    // Abstract method for account type
    public abstract String getAccountType();
}

// ============================================================
// SAVINGS ACCOUNT (Inheritance)
// ============================================================

class SavingsAccount extends Account implements Transferable {
    private double interestRate;

    public SavingsAccount(String accountNumber, String ownerName, 
                         double initialBalance, double interestRate) {
        super(accountNumber, ownerName, initialBalance);
        this.interestRate = interestRate;
        System.out.printf("✓ Savings Account created with %.2f%% interest%n", interestRate * 100);
    }

    @Override
    public void withdraw(double amount) {
        System.out.println("🏦 [Savings Account] Processing withdrawal...");
        
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            System.out.printf("✓ Withdrew $%.2f. New balance: $%.2f%n", amount, balance);
        } else {
            System.out.println("❌ Insufficient funds or invalid amount");
        }
    }

    public void applyInterest() {
        double interest = balance * interestRate;
        balance += interest;
        System.out.printf("✓ Interest applied: $%.2f (rate: %.2f%%)%n", interest, interestRate * 100);
    }

    @Override
    public void display() {
        System.out.println("\n=== Savings Account Details ===");
        System.out.println("Account Number: " + accountNumber);
        System.out.println("Owner: " + ownerName);
        System.out.printf("Balance: $%.2f%n", balance);
        System.out.printf("Interest Rate: %.2f%%%n", interestRate * 100);
    }

    @Override
    public String getAccountType() {
        return "Savings";
    }

    @Override
    public void transfer(Account destination, double amount) {
        System.out.println("🔄 Initiating transfer...");
        if (amount <= balance) {
            this.withdraw(amount);
            destination.deposit(amount);
            System.out.println("✓ Transfer completed");
        } else {
            System.out.println("❌ Transfer failed - insufficient funds");
        }
    }

    public double getInterestRate() { return interestRate; }
}

// ============================================================
// CHECKING ACCOUNT (Inheritance)
// ============================================================

class CheckingAccount extends Account implements Transferable {
    private double overdraftLimit;

    public CheckingAccount(String accountNumber, String ownerName,
                          double initialBalance, double overdraftLimit) {
        super(accountNumber, ownerName, initialBalance);
        this.overdraftLimit = overdraftLimit;
        System.out.printf("✓ Checking Account created with $%.2f overdraft%n", overdraftLimit);
    }

    @Override
    public void withdraw(double amount) {
        double availableBalance = balance + overdraftLimit;
        
        System.out.println("🏦 [Checking Account] Processing withdrawal...");
        
        if (amount > 0 && amount <= availableBalance) {
            balance -= amount;
            System.out.printf("✓ Withdrew $%.2f. New balance: $%.2f%n", amount, balance);
            
            if (balance < 0) {
                System.out.printf("⚠️  Overdraft used: $%.2f%n", -balance);
            }
        } else {
            System.out.println("❌ Exceeds overdraft limit");
        }
    }

    @Override
    public void display() {
        System.out.println("\n=== Checking Account Details ===");
        System.out.println("Account Number: " + accountNumber);
        System.out.println("Owner: " + ownerName);
        System.out.printf("Balance: $%.2f%n", balance);
        System.out.printf("Overdraft Limit: $%.2f%n", overdraftLimit);
    }

    @Override
    public String getAccountType() {
        return "Checking";
    }

    @Override
    public void transfer(Account destination, double amount) {
        System.out.println("🔄 Initiating transfer...");
        double availableBalance = balance + overdraftLimit;
        
        if (amount <= availableBalance) {
            this.withdraw(amount);
            destination.deposit(amount);
            System.out.println("✓ Transfer completed");
        } else {
            System.out.println("❌ Transfer failed - exceeds overdraft limit");
        }
    }

    public double getOverdraftLimit() { return overdraftLimit; }
}

// ============================================================
// MAIN CLASS - DEMONSTRATION
// ============================================================

public class BankAccount {
    public static void main(String[] args) {
        System.out.println("=== Bank Account System (Java OOP) ===\n");

        // Create accounts
        SavingsAccount savings = new SavingsAccount("SAV001", "Alice Johnson", 5000.0, 0.03);
        CheckingAccount checking = new CheckingAccount("CHK001", "Bob Smith", 1000.0, 500.0);

        System.out.println("\n--- Savings Account Operations ---");
        savings.deposit(500.0);
        savings.applyInterest();
        savings.display();

        System.out.println("\n--- Checking Account Operations ---");
        checking.withdraw(1200.0);  // Uses overdraft
        checking.deposit(300.0);
        checking.display();

        // Transfer demonstration
        System.out.println("\n--- Transfer Demo ---");
        savings.transfer(checking, 200.0);

        // Polymorphism demonstration
        System.out.println("\n--- Polymorphism Demo ---");
        Account[] accounts = { savings, checking };

        for (Account account : accounts) {
            System.out.println("\nAccount Type: " + account.getAccountType());
            account.display();
        }

        System.out.println("\n✓ Program completed successfully");
    }
}
