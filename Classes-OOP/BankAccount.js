/*
 * Bank Account System in JavaScript (ES6+)
 * Demonstrates OOP with ES6 classes, inheritance, encapsulation
 */

// ============================================================
// BASE ACCOUNT CLASS
// ============================================================

class Account {
    // Private fields (ES2022+)
    #accountNumber;
    #ownerName;
    #balance;

    constructor(accountNumber, ownerName, initialBalance) {
        this.#accountNumber = accountNumber;
        this.#ownerName = ownerName;
        this.#balance = initialBalance;
        console.log(`✓ Account created: ${accountNumber} for ${ownerName}`);
    }

    deposit(amount) {
        if (amount > 0) {
            this.#balance += amount;
            console.log(`✓ Deposited $${amount.toFixed(2)}. New balance: $${this.#balance.toFixed(2)}`);
        } else {
            console.log('❌ Invalid deposit amount');
        }
    }

    withdraw(amount) {
        if (amount > 0 && amount <= this.#balance) {
            this.#balance -= amount;
            console.log(`✓ Withdrew $${amount.toFixed(2)}. New balance: $${this.#balance.toFixed(2)}`);
        } else {
            console.log('❌ Insufficient funds or invalid amount');
        }
    }

    display() {
        console.log('\n=== Account Details ===');
        console.log(`Account Number: ${this.#accountNumber}`);
        console.log(`Owner: ${this.#ownerName}`);
        console.log(`Balance: $${this.#balance.toFixed(2)}`);
    }

    // Getters (encapsulation)
    get accountNumber() { return this.#accountNumber; }
    get ownerName() { return this.#ownerName; }
    get balance() { return this.#balance; }

    // Protected setter (for subclasses)
    _setBalance(value) { this.#balance = value; }
    _getBalance() { return this.#balance; }

    getAccountType() {
        return 'Generic';
    }
}

// ============================================================
// SAVINGS ACCOUNT (Inheritance)
// ============================================================

class SavingsAccount extends Account {
    #interestRate;

    constructor(accountNumber, ownerName, initialBalance, interestRate) {
        super(accountNumber, ownerName, initialBalance);
        this.#interestRate = interestRate;
        console.log(`✓ Savings Account created with ${(interestRate * 100).toFixed(2)}% interest`);
    }

    // Override withdraw (polymorphism)
    withdraw(amount) {
        console.log('🏦 [Savings Account] Processing withdrawal...');
        super.withdraw(amount);
    }

    applyInterest() {
        const balance = this._getBalance();
        const interest = balance * this.#interestRate;
        this._setBalance(balance + interest);
        console.log(`✓ Interest applied: $${interest.toFixed(2)} (rate: ${(this.#interestRate * 100).toFixed(2)}%)`);
    }

    display() {
        console.log('\n=== Savings Account Details ===');
        console.log(`Account Number: ${this.accountNumber}`);
        console.log(`Owner: ${this.ownerName}`);
        console.log(`Balance: $${this.balance.toFixed(2)}`);
        console.log(`Interest Rate: ${(this.#interestRate * 100).toFixed(2)}%`);
    }

    getAccountType() {
        return 'Savings';
    }

    get interestRate() { return this.#interestRate; }
}

// ============================================================
// CHECKING ACCOUNT (Inheritance)
// ============================================================

class CheckingAccount extends Account {
    #overdraftLimit;

    constructor(accountNumber, ownerName, initialBalance, overdraftLimit) {
        super(accountNumber, ownerName, initialBalance);
        this.#overdraftLimit = overdraftLimit;
        console.log(`✓ Checking Account created with $${overdraftLimit.toFixed(2)} overdraft`);
    }

    // Override withdraw (polymorphism)
    withdraw(amount) {
        const balance = this._getBalance();
        const availableBalance = balance + this.#overdraftLimit;

        console.log('🏦 [Checking Account] Processing withdrawal...');

        if (amount > 0 && amount <= availableBalance) {
            this._setBalance(balance - amount);
            console.log(`✓ Withdrew $${amount.toFixed(2)}. New balance: $${this._getBalance().toFixed(2)}`);

            if (this._getBalance() < 0) {
                console.log(`⚠️  Overdraft used: $${(-this._getBalance()).toFixed(2)}`);
            }
        } else {
            console.log('❌ Exceeds overdraft limit');
        }
    }

    display() {
        console.log('\n=== Checking Account Details ===');
        console.log(`Account Number: ${this.accountNumber}`);
        console.log(`Owner: ${this.ownerName}`);
        console.log(`Balance: $${this.balance.toFixed(2)}`);
        console.log(`Overdraft Limit: $${this.#overdraftLimit.toFixed(2)}`);
    }

    getAccountType() {
        return 'Checking';
    }

    get overdraftLimit() { return this.#overdraftLimit; }
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

console.log('=== Bank Account System (JavaScript ES6+ OOP) ===\n');

// Create accounts
const savings = new SavingsAccount('SAV001', 'Alice Johnson', 5000.0, 0.03);
const checking = new CheckingAccount('CHK001', 'Bob Smith', 1000.0, 500.0);

console.log('\n--- Savings Account Operations ---');
savings.deposit(500.0);
savings.applyInterest();
savings.display();

console.log('\n--- Checking Account Operations ---');
checking.withdraw(1200.0);  // Uses overdraft
checking.deposit(300.0);
checking.display();

// Polymorphism demonstration
console.log('\n--- Polymorphism Demo ---');
const accounts = [savings, checking];

accounts.forEach(account => {
    console.log(`\nAccount Type: ${account.getAccountType()}`);
    account.display();
});

// Duck typing demonstration (JavaScript specialty)
console.log('\n--- Duck Typing Demo ---');
function processAccount(account) {
    console.log(`Processing account for ${account.ownerName}`);
    account.deposit(100);
}

accounts.forEach(processAccount);

console.log('\n✓ Program completed successfully');
