/*
 * Bank Account System in C++
 * Demonstrates full OOP: classes, inheritance, polymorphism, encapsulation
 */

#include <iostream>
#include <string>
#include <iomanip>
#include <memory>
#include <vector>

// ============================================================
// BASE ACCOUNT CLASS
// ============================================================

class Account {
protected:
    std::string accountNumber;
    std::string ownerName;
    double balance;

public:
    // Constructor
    Account(const std::string& accountNumber, const std::string& ownerName, double initialBalance)
        : accountNumber(accountNumber), ownerName(ownerName), balance(initialBalance) {
        std::cout << "✓ Account created: " << accountNumber << " for " << ownerName << std::endl;
    }

    // Virtual destructor (important for polymorphism)
    virtual ~Account() {
        std::cout << "✓ Account destroyed: " << accountNumber << std::endl;
    }

    // Virtual methods (can be overridden)
    virtual void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            std::cout << "✓ Deposited $" << std::fixed << std::setprecision(2) 
                     << amount << ". New balance: $" << balance << std::endl;
        } else {
            std::cout << "❌ Invalid deposit amount" << std::endl;
        }
    }

    virtual void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            std::cout << "✓ Withdrew $" << std::fixed << std::setprecision(2) 
                     << amount << ". New balance: $" << balance << std::endl;
        } else {
            std::cout << "❌ Insufficient funds or invalid amount" << std::endl;
        }
    }

    virtual void display() const {
        std::cout << "\n=== Account Details ===" << std::endl;
        std::cout << "Account Number: " << accountNumber << std::endl;
        std::cout << "Owner: " << ownerName << std::endl;
        std::cout << "Balance: $" << std::fixed << std::setprecision(2) << balance << std::endl;
    }

    // Getters (encapsulation)
    std::string getAccountNumber() const { return accountNumber; }
    std::string getOwnerName() const { return ownerName; }
    double getBalance() const { return balance; }

    // Pure virtual method would make this abstract
    virtual std::string getAccountType() const = 0;
};

// ============================================================
// SAVINGS ACCOUNT (Inheritance)
// ============================================================

class SavingsAccount : public Account {
private:
    double interestRate;

public:
    SavingsAccount(const std::string& accountNumber, const std::string& ownerName,
                   double initialBalance, double interestRate)
        : Account(accountNumber, ownerName, initialBalance), interestRate(interestRate) {
        std::cout << "✓ Savings Account created with " << (interestRate * 100) << "% interest" << std::endl;
    }

    // Override withdraw (polymorphism)
    void withdraw(double amount) override {
        std::cout << "🏦 [Savings Account] Processing withdrawal..." << std::endl;
        Account::withdraw(amount);
    }

    // Additional method specific to SavingsAccount
    void applyInterest() {
        double interest = balance * interestRate;
        balance += interest;
        std::cout << "✓ Interest applied: $" << std::fixed << std::setprecision(2) 
                 << interest << " (rate: " << (interestRate * 100) << "%)" << std::endl;
    }

    void display() const override {
        std::cout << "\n=== Savings Account Details ===" << std::endl;
        std::cout << "Account Number: " << accountNumber << std::endl;
        std::cout << "Owner: " << ownerName << std::endl;
        std::cout << "Balance: $" << std::fixed << std::setprecision(2) << balance << std::endl;
        std::cout << "Interest Rate: " << (interestRate * 100) << "%" << std::endl;
    }

    std::string getAccountType() const override {
        return "Savings";
    }

    double getInterestRate() const { return interestRate; }
};

// ============================================================
// CHECKING ACCOUNT (Inheritance)
// ============================================================

class CheckingAccount : public Account {
private:
    double overdraftLimit;

public:
    CheckingAccount(const std::string& accountNumber, const std::string& ownerName,
                    double initialBalance, double overdraftLimit)
        : Account(accountNumber, ownerName, initialBalance), overdraftLimit(overdraftLimit) {
        std::cout << "✓ Checking Account created with $" << overdraftLimit << " overdraft" << std::endl;
    }

    // Override withdraw (polymorphism)
    void withdraw(double amount) override {
        double availableBalance = balance + overdraftLimit;
        
        std::cout << "🏦 [Checking Account] Processing withdrawal..." << std::endl;
        
        if (amount > 0 && amount <= availableBalance) {
            balance -= amount;
            std::cout << "✓ Withdrew $" << std::fixed << std::setprecision(2) 
                     << amount << ". New balance: $" << balance << std::endl;
            
            if (balance < 0) {
                std::cout << "⚠️  Overdraft used: $" << std::fixed << std::setprecision(2) 
                         << -balance << std::endl;
            }
        } else {
            std::cout << "❌ Exceeds overdraft limit" << std::endl;
        }
    }

    void display() const override {
        std::cout << "\n=== Checking Account Details ===" << std::endl;
        std::cout << "Account Number: " << accountNumber << std::endl;
        std::cout << "Owner: " << ownerName << std::endl;
        std::cout << "Balance: $" << std::fixed << std::setprecision(2) << balance << std::endl;
        std::cout << "Overdraft Limit: $" << overdraftLimit << std::endl;
    }

    std::string getAccountType() const override {
        return "Checking";
    }

    double getOverdraftLimit() const { return overdraftLimit; }
};

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    std::cout << "=== Bank Account System (C++ OOP) ===\n" << std::endl;

    // Using smart pointers for automatic memory management
    auto savings = std::make_unique<SavingsAccount>("SAV001", "Alice Johnson", 5000.0, 0.03);
    auto checking = std::make_unique<CheckingAccount>("CHK001", "Bob Smith", 1000.0, 500.0);

    std::cout << "\n--- Savings Account Operations ---" << std::endl;
    savings->deposit(500.0);
    savings->applyInterest();
    savings->display();

    std::cout << "\n--- Checking Account Operations ---" << std::endl;
    checking->withdraw(1200.0);  // Uses overdraft
    checking->deposit(300.0);
    checking->display();

    // Polymorphism demonstration
    std::cout << "\n--- Polymorphism Demo ---" << std::endl;
    std::vector<Account*> accounts = { savings.get(), checking.get() };

    for (Account* account : accounts) {
        std::cout << "\nAccount Type: " << account->getAccountType() << std::endl;
        account->display();
    }

    std::cout << "\n✓ Program completed successfully" << std::endl;
    return 0;
}
