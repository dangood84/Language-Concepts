/*
 * Structures in JavaScript
 * JavaScript doesn't have native structs, but objects serve the same purpose
 */

// ============================================================
// BASIC OBJECT (as struct)
// ============================================================

function demonstrateBasicObject() {
    console.log('=== Basic Object (as Struct) ===');
    
    // Object literal
    const point = {
        x: 10,
        y: 20
    };
    
    console.log(`Point: (${point.x}, ${point.y})`);
    
    // Modify properties
    point.x = 15;
    console.log(`After modification: (${point.x}, ${point.y})`);
}

// ============================================================
// NESTED OBJECTS
// ============================================================

function demonstrateNestedObjects() {
    console.log('\n=== Nested Objects ===');
    
    const person = {
        name: 'Alice Johnson',
        age: 30,
        address: {
            street: '123 Main St',
            city: 'Springfield',
            zipCode: '12345'
        }
    };
    
    console.log(`Name: ${person.name}`);
    console.log(`Age: ${person.age}`);
    console.log(`Address: ${person.address.street}, ${person.address.city} ${person.address.zipCode}`);
}

// ============================================================
// CONSTRUCTOR FUNCTION (Pre-ES6)
// ============================================================

function Point(x, y) {
    this.x = x;
    this.y = y;
}

Point.prototype.toString = function() {
    return `Point(${this.x}, ${this.y})`;
};

function demonstrateConstructorFunction() {
    console.log('\n=== Constructor Function ===');
    
    const p1 = new Point(10, 20);
    console.log(p1.toString());
}

// ============================================================
// FACTORY FUNCTION
// ============================================================

function createRectangle(width, height) {
    return {
        width,
        height,
        area() {
            return this.width * this.height;
        },
        perimeter() {
            return 2 * (this.width + this.height);
        },
        toString() {
            return `Rectangle(${this.width}x${this.height})`;
        }
    };
}

function demonstrateFactoryFunction() {
    console.log('\n=== Factory Function ===');
    
    const rect = createRectangle(10, 5);
    console.log(rect.toString());
    console.log(`Area: ${rect.area()}`);
    console.log(`Perimeter: ${rect.perimeter()}`);
}

// ============================================================
// ARRAY OF OBJECTS
// ============================================================

function demonstrateArrayOfObjects() {
    console.log('\n=== Array of Objects ===');
    
    const accounts = [
        { id: 1001, name: 'Alice', balance: 5000.50 },
        { id: 1002, name: 'Bob', balance: 3200.75 },
        { id: 1003, name: 'Charlie', balance: 7500.00 }
    ];
    
    console.log('Bank Accounts:');
    accounts.forEach(account => {
        console.log(`  ID: ${account.id}, Name: ${account.name}, Balance: $${account.balance.toFixed(2)}`);
    });
    
    // Sort by balance
    const sorted = [...accounts].sort((a, b) => b.balance - a.balance);
    console.log('\nSorted by balance:');
    sorted.forEach(account => {
        console.log(`  ${account.name}: $${account.balance.toFixed(2)}`);
    });
}

// ============================================================
// DESTRUCTURING
// ============================================================

function demonstrateDestructuring() {
    console.log('\n=== Destructuring ===');
    
    const person = {
        name: 'Bob Smith',
        age: 35,
        address: {
            street: '456 Elm St',
            city: 'Portland',
            zipCode: '97201'
        }
    };
    
    // Destructure top-level properties
    const { name, age } = person;
    console.log(`Name: ${name}, Age: ${age}`);
    
    // Destructure nested properties
    const { address: { city, zipCode } } = person;
    console.log(`Location: ${city}, ${zipCode}`);
}

// ============================================================
// OBJECT.FREEZE (Immutable struct)
// ============================================================

function demonstrateImmutableObject() {
    console.log('\n=== Immutable Object (Object.freeze) ===');
    
    const point = Object.freeze({
        x: 10,
        y: 20
    });
    
    console.log(`Point: (${point.x}, ${point.y})`);
    
    // Attempt to modify (fails silently in non-strict mode)
    point.x = 15;
    console.log(`After attempted modification: (${point.x}, ${point.y})`);
    console.log('(Modification was blocked by Object.freeze)');
}

// ============================================================
// SPREAD OPERATOR (Copy/Merge)
// ============================================================

function demonstrateSpreadOperator() {
    console.log('\n=== Spread Operator ===');
    
    const point1 = { x: 10, y: 20 };
    const point2 = { ...point1 };  // Shallow copy
    
    console.log('Original:', point1);
    console.log('Copy:', point2);
    
    // Merge objects
    const defaults = { x: 0, y: 0, z: 0 };
    const custom = { x: 10, y: 20 };
    const merged = { ...defaults, ...custom };
    console.log('Merged:', merged);
}

// ============================================================
// OBJECT VALIDATION (Type checking at runtime)
// ============================================================

function createPerson(name, age, address) {
    if (typeof name !== 'string') throw new TypeError('name must be a string');
    if (typeof age !== 'number') throw new TypeError('age must be a number');
    
    return {
        name,
        age,
        address,
        isAdult() {
            return this.age >= 18;
        }
    };
}

function demonstrateValidation() {
    console.log('\n=== Object Validation ===');
    
    const person = createPerson('Alice', 30, {
        street: '123 Main St',
        city: 'NYC',
        zipCode: '10001'
    });
    
    console.log(`Person: ${person.name}, Adult: ${person.isAdult()}`);
}

// ============================================================
// PRIVATE FIELDS (using closures)
// ============================================================

function createAccount(id, initialBalance) {
    let balance = initialBalance;  // Private variable
    
    return {
        id,
        getBalance() {
            return balance;
        },
        deposit(amount) {
            if (amount > 0) {
                balance += amount;
                console.log(`Deposited $${amount}. New balance: $${balance}`);
            }
        },
        withdraw(amount) {
            if (amount > 0 && amount <= balance) {
                balance -= amount;
                console.log(`Withdrew $${amount}. New balance: $${balance}`);
            } else {
                console.log('Insufficient funds');
            }
        }
    };
}

function demonstratePrivateFields() {
    console.log('\n=== Private Fields (Closures) ===');
    
    const account = createAccount(1001, 1000);
    console.log(`Initial balance: $${account.getBalance()}`);
    account.deposit(500);
    account.withdraw(200);
}

// ============================================================
// COMPARISON
// ============================================================

function demonstrateComparison() {
    console.log('\n=== Comparing Objects ===');
    
    const p1 = { x: 10, y: 20 };
    const p2 = { x: 10, y: 20 };
    const p3 = p1;
    
    console.log('p1 === p2:', p1 === p2);  // false (different references)
    console.log('p1 === p3:', p1 === p3);  // true (same reference)
    
    // Deep equality check
    const deepEqual = JSON.stringify(p1) === JSON.stringify(p2);
    console.log('Deep equal (JSON):', deepEqual);
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

console.log('=== Structures in JavaScript ===\n');

demonstrateBasicObject();
demonstrateNestedObjects();
demonstrateConstructorFunction();
demonstrateFactoryFunction();
demonstrateArrayOfObjects();
demonstrateDestructuring();
demonstrateImmutableObject();
demonstrateSpreadOperator();
demonstrateValidation();
demonstratePrivateFields();
demonstrateComparison();

console.log('\n💡 JavaScript Struct Alternatives:');
console.log('   ✓ Use object literals for simple data');
console.log('   ✓ Use factory functions for encapsulation');
console.log('   ✓ Use Object.freeze for immutability');
console.log('   ✓ Consider TypeScript for compile-time type safety');
console.log('   ✗ No native struct keyword');

console.log('\n✓ Program completed successfully');
