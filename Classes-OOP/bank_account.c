/* 
 * Bank Account System in C
 * Demonstrates OOP patterns in C using structs and function pointers
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// ============================================================
// BASE ACCOUNT (Simulated Class)
// ============================================================

typedef struct Account Account;

struct Account {
    char accountNumber[20];
    char ownerName[100];
    double balance;
    
    // "Virtual" methods (function pointers)
    void (*deposit)(Account*, double);
    void (*withdraw)(Account*, double);
    void (*display)(Account*);
    void (*destroy)(Account*);
};

// Account "methods"
void account_deposit(Account* self, double amount) {
    if (amount > 0) {
        self->balance += amount;
        printf("✓ Deposited $%.2f. New balance: $%.2f\n", amount, self->balance);
    } else {
        printf("❌ Invalid deposit amount\n");
    }
}

void account_withdraw(Account* self, double amount) {
    if (amount > 0 && amount <= self->balance) {
        self->balance -= amount;
        printf("✓ Withdrew $%.2f. New balance: $%.2f\n", amount, self->balance);
    } else {
        printf("❌ Insufficient funds or invalid amount\n");
    }
}

void account_display(Account* self) {
    printf("\n=== Account Details ===\n");
    printf("Account Number: %s\n", self->accountNumber);
    printf("Owner: %s\n", self->ownerName);
    printf("Balance: $%.2f\n", self->balance);
}

void account_destroy(Account* self) {
    free(self);
}

// Account "constructor"
Account* account_new(const char* accountNumber, const char* ownerName, double initialBalance) {
    Account* account = (Account*)malloc(sizeof(Account));
    
    strcpy(account->accountNumber, accountNumber);
    strcpy(account->ownerName, ownerName);
    account->balance = initialBalance;
    
    // Set function pointers
    account->deposit = account_deposit;
    account->withdraw = account_withdraw;
    account->display = account_display;
    account->destroy = account_destroy;
    
    printf("✓ Account created: %s for %s\n", accountNumber, ownerName);
    return account;
}

// ============================================================
// SAVINGS ACCOUNT (Inheritance Simulation)
// ============================================================

typedef struct {
    Account base;  // "Inherits" from Account
    double interestRate;
} SavingsAccount;

void savings_withdraw(Account* self, double amount) {
    printf("🏦 [Savings Account] Processing withdrawal...\n");
    account_withdraw(self, amount);
}

void savings_apply_interest(SavingsAccount* self) {
    double interest = self->base.balance * self->interestRate;
    self->base.balance += interest;
    printf("✓ Interest applied: $%.2f (rate: %.2f%%)\n", interest, self->interestRate * 100);
}

void savings_display(Account* self) {
    SavingsAccount* savings = (SavingsAccount*)self;
    printf("\n=== Savings Account Details ===\n");
    printf("Account Number: %s\n", self->accountNumber);
    printf("Owner: %s\n", self->ownerName);
    printf("Balance: $%.2f\n", self->balance);
    printf("Interest Rate: %.2f%%\n", savings->interestRate * 100);
}

SavingsAccount* savings_account_new(const char* accountNumber, const char* ownerName, 
                                    double initialBalance, double interestRate) {
    SavingsAccount* savings = (SavingsAccount*)malloc(sizeof(SavingsAccount));
    
    // Initialize base "class"
    strcpy(savings->base.accountNumber, accountNumber);
    strcpy(savings->base.ownerName, ownerName);
    savings->base.balance = initialBalance;
    savings->interestRate = interestRate;
    
    // Override methods (polymorphism)
    savings->base.deposit = account_deposit;
    savings->base.withdraw = savings_withdraw;
    savings->base.display = savings_display;
    savings->base.destroy = account_destroy;
    
    printf("✓ Savings Account created: %s (%.2f%% interest)\n", accountNumber, interestRate * 100);
    return savings;
}

// ============================================================
// CHECKING ACCOUNT (Inheritance Simulation)
// ============================================================

typedef struct {
    Account base;
    double overdraftLimit;
} CheckingAccount;

void checking_withdraw(Account* self, double amount) {
    CheckingAccount* checking = (CheckingAccount*)self;
    double availableBalance = self->balance + checking->overdraftLimit;
    
    printf("🏦 [Checking Account] Processing withdrawal...\n");
    
    if (amount > 0 && amount <= availableBalance) {
        self->balance -= amount;
        printf("✓ Withdrew $%.2f. New balance: $%.2f\n", amount, self->balance);
        
        if (self->balance < 0) {
            printf("⚠️  Overdraft used: $%.2f\n", -self->balance);
        }
    } else {
        printf("❌ Exceeds overdraft limit\n");
    }
}

void checking_display(Account* self) {
    CheckingAccount* checking = (CheckingAccount*)self;
    printf("\n=== Checking Account Details ===\n");
    printf("Account Number: %s\n", self->accountNumber);
    printf("Owner: %s\n", self->ownerName);
    printf("Balance: $%.2f\n", self->balance);
    printf("Overdraft Limit: $%.2f\n", checking->overdraftLimit);
}

CheckingAccount* checking_account_new(const char* accountNumber, const char* ownerName,
                                      double initialBalance, double overdraftLimit) {
    CheckingAccount* checking = (CheckingAccount*)malloc(sizeof(CheckingAccount));
    
    strcpy(checking->base.accountNumber, accountNumber);
    strcpy(checking->base.ownerName, ownerName);
    checking->base.balance = initialBalance;
    checking->overdraftLimit = overdraftLimit;
    
    // Override methods
    checking->base.deposit = account_deposit;
    checking->base.withdraw = checking_withdraw;
    checking->base.display = checking_display;
    checking->base.destroy = account_destroy;
    
    printf("✓ Checking Account created: %s (overdraft: $%.2f)\n", accountNumber, overdraftLimit);
    return checking;
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    printf("=== Bank Account System (C - Struct-based OOP) ===\n\n");
    
    // Create accounts
    SavingsAccount* savings = savings_account_new("SAV001", "Alice Johnson", 5000.0, 0.03);
    CheckingAccount* checking = checking_account_new("CHK001", "Bob Smith", 1000.0, 500.0);
    
    printf("\n--- Savings Account Operations ---\n");
    savings->base.deposit(&savings->base, 500.0);
    savings_apply_interest(savings);
    savings->base.display(&savings->base);
    
    printf("\n--- Checking Account Operations ---\n");
    checking->base.withdraw(&checking->base, 1200.0);  // Uses overdraft
    checking->base.deposit(&checking->base, 300.0);
    checking->base.display(&checking->base);
    
    // Polymorphism demonstration
    printf("\n--- Polymorphism Demo ---\n");
    Account* accounts[] = { (Account*)savings, (Account*)checking };
    
    for (int i = 0; i < 2; i++) {
        accounts[i]->display(accounts[i]);
    }
    
    // Cleanup
    savings->base.destroy((Account*)savings);
    checking->base.destroy((Account*)checking);
    
    printf("\n✓ Program completed successfully\n");
    return 0;
}
