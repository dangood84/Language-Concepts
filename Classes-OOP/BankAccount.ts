/*
 * Bank Account System in TypeScript
 * Demonstrates OOP with type safety, interfaces, abstract classes
 */

// ============================================================
// INTERFACES (Type Contracts)
// ============================================================

interface Transferable {
    transfer(destination: Account, amount: number): void;
}

interface AccountInfo {
    accountNumber: string;
    ownerName: string;
    balance: number;
    accountType: string;
}

// ============================================================
// ABSTRACT BASE ACCOUNT CLASS
// ============================================================

abstract class Account {
    protected accountNumber: string;
    protected ownerName: string;
    protected balance: number;

    constructor(accountNumber: string, ownerName: string, initialBalance: number) {
        this.accountNumber = accountNumber;
        this.ownerName = ownerName;
        this.balance = initialBalance;
        console.log(`✓ Account created: ${accountNumber} for ${ownerName}`);
    }

    deposit(amount: number): void {
        if (amount > 0) {
            this.balance += amount;
            console.log(`✓ Deposited $${amount.toFixed(2)}. New balance: $${this.balance.toFixed(2)}`);
        } else {
            console.log('❌ Invalid deposit amount');
        }
    }

    // Abstract method (must be implemented by subclasses)
    abstract withdraw(amount: number): void;

    display(): void {
        console.log('\n=== Account Details ===');
        console.log(`Account Number: ${this.accountNumber}`);
        console.log(`Owner: ${this.ownerName}`);
        console.log(`Balance: $${this.balance.toFixed(2)}`);
    }

    // Getters (encapsulation)
    getAccountNumber(): string { return this.accountNumber; }
    getOwnerName(): string { return this.ownerName; }
    getBalance(): number { return this.balance; }

    // Abstract method for account type
    abstract getAccountType(): string;

    // Method to get account info
    getAccountInfo(): AccountInfo {
        return {
            accountNumber: this.accountNumber,
            ownerName: this.ownerName,
            balance: this.balance,
            accountType: this.getAccountType()
        };
    }
}

// ============================================================
// SAVINGS ACCOUNT (Inheritance + Interface)
// ============================================================

class SavingsAccount extends Account implements Transferable {
    private interestRate: number;

    constructor(accountNumber: string, ownerName: string, 
                initialBalance: number, interestRate: number) {
        super(accountNumber, ownerName, initialBalance);
        this.interestRate = interestRate;
        console.log(`✓ Savings Account created with ${(interestRate * 100).toFixed(2)}% interest`);
    }

    withdraw(amount: number): void {
        console.log('🏦 [Savings Account] Processing withdrawal...');

        if (amount > 0 && amount <= this.balance) {
            this.balance -= amount;
            console.log(`✓ Withdrew $${amount.toFixed(2)}. New balance: $${this.balance.toFixed(2)}`);
        } else {
            console.log('❌ Insufficient funds or invalid amount');
        }
    }

    applyInterest(): void {
        const interest = this.balance * this.interestRate;
        this.balance += interest;
        console.log(`✓ Interest applied: $${interest.toFixed(2)} (rate: ${(this.interestRate * 100).toFixed(2)}%)`);
    }

    display(): void {
        console.log('\n=== Savings Account Details ===');
        console.log(`Account Number: ${this.accountNumber}`);
        console.log(`Owner: ${this.ownerName}`);
        console.log(`Balance: $${this.balance.toFixed(2)}`);
        console.log(`Interest Rate: ${(this.interestRate * 100).toFixed(2)}%`);
    }

    getAccountType(): string {
        return 'Savings';
    }

    transfer(destination: Account, amount: number): void {
        console.log('🔄 Initiating transfer...');
        if (amount <= this.balance) {
            this.withdraw(amount);
            destination.deposit(amount);
            console.log('✓ Transfer completed');
        } else {
            console.log('❌ Transfer failed - insufficient funds');
        }
    }

    getInterestRate(): number { return this.interestRate; }
}

// ============================================================
// CHECKING ACCOUNT (Inheritance + Interface)
// ============================================================

class CheckingAccount extends Account implements Transferable {
    private overdraftLimit: number;

    constructor(accountNumber: string, ownerName: string,
                initialBalance: number, overdraftLimit: number) {
        super(accountNumber, ownerName, initialBalance);
        this.overdraftLimit = overdraftLimit;
        console.log(`✓ Checking Account created with $${overdraftLimit.toFixed(2)} overdraft`);
    }

    withdraw(amount: number): void {
        const availableBalance = this.balance + this.overdraftLimit;

        console.log('🏦 [Checking Account] Processing withdrawal...');

        if (amount > 0 && amount <= availableBalance) {
            this.balance -= amount;
            console.log(`✓ Withdrew $${amount.toFixed(2)}. New balance: $${this.balance.toFixed(2)}`);

            if (this.balance < 0) {
                console.log(`⚠️  Overdraft used: $${(-this.balance).toFixed(2)}`);
            }
        } else {
            console.log('❌ Exceeds overdraft limit');
        }
    }

    display(): void {
        console.log('\n=== Checking Account Details ===');
        console.log(`Account Number: ${this.accountNumber}`);
        console.log(`Owner: ${this.ownerName}`);
        console.log(`Balance: $${this.balance.toFixed(2)}`);
        console.log(`Overdraft Limit: $${this.overdraftLimit.toFixed(2)}`);
    }

    getAccountType(): string {
        return 'Checking';
    }

    transfer(destination: Account, amount: number): void {
        console.log('🔄 Initiating transfer...');
        const availableBalance = this.balance + this.overdraftLimit;

        if (amount <= availableBalance) {
            this.withdraw(amount);
            destination.deposit(amount);
            console.log('✓ Transfer completed');
        } else {
            console.log('❌ Transfer failed - exceeds overdraft limit');
        }
    }

    getOverdraftLimit(): number { return this.overdraftLimit; }
}

// ============================================================
// GENERIC ACCOUNT MANAGER (Demonstrates Generics)
// ============================================================

class AccountManager<T extends Account> {
    private accounts: T[] = [];

    addAccount(account: T): void {
        this.accounts.push(account);
        console.log(`✓ Account ${account.getAccountNumber()} added to manager`);
    }

    getTotalBalance(): number {
        return this.accounts.reduce((sum, account) => sum + account.getBalance(), 0);
    }

    displayAll(): void {
        console.log('\n=== All Managed Accounts ===');
        this.accounts.forEach(account => account.display());
    }

    getAccounts(): T[] {
        return [...this.accounts];
    }
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

console.log('=== Bank Account System (TypeScript OOP) ===\n');

// Create accounts with type safety
const savings: SavingsAccount = new SavingsAccount('SAV001', 'Alice Johnson', 5000.0, 0.03);
const checking: CheckingAccount = new CheckingAccount('CHK001', 'Bob Smith', 1000.0, 500.0);

console.log('\n--- Savings Account Operations ---');
savings.deposit(500.0);
savings.applyInterest();
savings.display();

console.log('\n--- Checking Account Operations ---');
checking.withdraw(1200.0);  // Uses overdraft
checking.deposit(300.0);
checking.display();

// Transfer demonstration
console.log('\n--- Transfer Demo ---');
savings.transfer(checking, 200.0);

// Polymorphism demonstration
console.log('\n--- Polymorphism Demo ---');
const accounts: Account[] = [savings, checking];

accounts.forEach((account: Account) => {
    console.log(`\nAccount Type: ${account.getAccountType()}`);
    account.display();
});

// Generic Account Manager demonstration
console.log('\n--- Account Manager Demo ---');
const manager = new AccountManager<Account>();
manager.addAccount(savings);
manager.addAccount(checking);
console.log(`Total balance across all accounts: $${manager.getTotalBalance().toFixed(2)}`);

// Type safety demonstration
console.log('\n--- Type Safety Demo ---');
const accountInfo: AccountInfo = savings.getAccountInfo();
console.log('Account Info:', accountInfo);

console.log('\n✓ Program completed successfully');
