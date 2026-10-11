/*
 * Structures in TypeScript
 * Demonstrates interfaces, type literals, and object structures
 */

// ============================================================
// BASIC INTERFACE (Type-safe Struct)
// ============================================================

interface Point {
    x: number;
    y: number;
}

interface Point3D {
    x: number;
    y: number;
    z: number;
}

function demonstrateBasicStructs(): void {
    console.log('=== Basic Structures (Interfaces) ===');
    
    const p1: Point = { x: 10, y: 20 };
    console.log(`Point p1: (${p1.x}, ${p1.y})`);
    
    const p3d: Point3D = { x: 1.5, y: 2.5, z: 3.5 };
    console.log(`Point3D: (${p3d.x}, ${p3d.y}, ${p3d.z})`);
}

// ============================================================
// NESTED STRUCTURES
// ============================================================

interface Address {
    street: string;
    city: string;
    zipCode: string;
}

interface Person {
    name: string;
    age: number;
    address: Address;  // Nested struct
}

function demonstrateNestedStructs(): void {
    console.log('\n=== Nested Structures ===');
    
    const person: Person = {
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
// OPTIONAL AND READONLY PROPERTIES
// ============================================================

interface Account {
    readonly id: number;    // Cannot be modified after creation
    name: string;
    balance: number;
    email?: string;         // Optional property
}

function demonstrateOptionalReadonly(): void {
    console.log('\n=== Optional and Readonly Properties ===');
    
    const account: Account = {
        id: 1001,
        name: 'Alice',
        balance: 5000.50
        // email is optional
    };
    
    console.log(`Account: ID=${account.id}, Name=${account.name}, Balance=$${account.balance}`);
    
    account.balance += 100;  // OK
    // account.id = 1002;    // ✗ Error: Cannot assign to 'id' because it is readonly
    
    account.email = 'alice@example.com';  // Optional property can be added
    console.log(`Email: ${account.email}`);
}

// ============================================================
// TYPE ALIASES (Alternative to Interfaces)
// ============================================================

type Rectangle = {
    width: number;
    height: number;
};

type Circle = {
    radius: number;
};

type Shape = Rectangle | Circle;  // Union type

function getArea(shape: Shape): number {
    if ('width' in shape) {
        return shape.width * shape.height;
    } else {
        return Math.PI * shape.radius ** 2;
    }
}

function demonstrateTypeAliases(): void {
    console.log('\n=== Type Aliases ===');
    
    const rect: Rectangle = { width: 10, height: 5 };
    const circle: Circle = { radius: 7 };
    
    console.log(`Rectangle area: ${getArea(rect)}`);
    console.log(`Circle area: ${getArea(circle).toFixed(2)}`);
}

// ============================================================
// ARRAY OF STRUCTURES
// ============================================================

interface Product {
    id: number;
    name: string;
    price: number;
    inStock: boolean;
}

function demonstrateArrayOfStructs(): void {
    console.log('\n=== Array of Structures ===');
    
    const products: Product[] = [
        { id: 101, name: 'Laptop', price: 999.99, inStock: true },
        { id: 102, name: 'Mouse', price: 29.99, inStock: true },
        { id: 103, name: 'Keyboard', price: 79.99, inStock: false }
    ];
    
    console.log('Products:');
    products.forEach(p => {
        console.log(`  ID: ${p.id}, Name: ${p.name}, Price: $${p.price}, In Stock: ${p.inStock}`);
    });
    
    // Filter and map operations
    const inStockProducts = products.filter(p => p.inStock);
    console.log(`\nIn-stock products: ${inStockProducts.length}`);
}

// ============================================================
// DESTRUCTURING
// ============================================================

function demonstrateDestructuring(): void {
    console.log('\n=== Destructuring ===');
    
    const person: Person = {
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
    
    // With renaming
    const { name: personName } = person;
    console.log(`Person name: ${personName}`);
}

// ============================================================
// INTERFACE EXTENSION (Inheritance)
// ============================================================

interface Animal {
    name: string;
    age: number;
}

interface Dog extends Animal {
    breed: string;
    bark(): void;
}

function demonstrateInterfaceExtension(): void {
    console.log('\n=== Interface Extension ===');
    
    const dog: Dog = {
        name: 'Buddy',
        age: 3,
        breed: 'Golden Retriever',
        bark() {
            console.log('Woof! Woof!');
        }
    };
    
    console.log(`Dog: ${dog.name}, ${dog.age} years old, Breed: ${dog.breed}`);
    dog.bark();
}

// ============================================================
// INDEX SIGNATURES (Dynamic Properties)
// ============================================================

interface Dictionary {
    [key: string]: string | number;
}

function demonstrateIndexSignatures(): void {
    console.log('\n=== Index Signatures ===');
    
    const config: Dictionary = {
        apiUrl: 'https://api.example.com',
        timeout: 5000,
        retries: 3
    };
    
    console.log('Configuration:');
    for (const key in config) {
        console.log(`  ${key}: ${config[key]}`);
    }
}

// ============================================================
// FUNCTIONS IN INTERFACES
// ============================================================

interface Calculator {
    add(a: number, b: number): number;
    subtract(a: number, b: number): number;
}

const calculator: Calculator = {
    add: (a, b) => a + b,
    subtract: (a, b) => a - b
};

function demonstrateFunctionsInInterfaces(): void {
    console.log('\n=== Functions in Interfaces ===');
    
    console.log(`5 + 3 = ${calculator.add(5, 3)}`);
    console.log(`5 - 3 = ${calculator.subtract(5, 3)}`);
}

// ============================================================
// GENERICS WITH STRUCTURES
// ============================================================

interface Result<T> {
    success: boolean;
    data?: T;
    error?: string;
}

function createSuccessResult<T>(data: T): Result<T> {
    return { success: true, data };
}

function createErrorResult<T>(error: string): Result<T> {
    return { success: false, error };
}

function demonstrateGenerics(): void {
    console.log('\n=== Generics with Structures ===');
    
    const numberResult: Result<number> = createSuccessResult(42);
    console.log(`Number result: success=${numberResult.success}, data=${numberResult.data}`);
    
    const stringResult: Result<string> = createErrorResult('Connection failed');
    console.log(`String result: success=${stringResult.success}, error=${stringResult.error}`);
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

console.log('=== Structures in TypeScript ===\n');

demonstrateBasicStructs();
demonstrateNestedStructs();
demonstrateOptionalReadonly();
demonstrateTypeAliases();
demonstrateArrayOfStructs();
demonstrateDestructuring();
demonstrateInterfaceExtension();
demonstrateIndexSignatures();
demonstrateFunctionsInInterfaces();
demonstrateGenerics();

console.log('\n💡 TypeScript Best Practices:');
console.log('   - Use interfaces for object shapes');
console.log('   - Use type aliases for unions/intersections');
console.log('   - Mark properties readonly when appropriate');
console.log('   - Use optional properties for flexibility');
console.log('   - Leverage destructuring for cleaner code');

console.log('\n✓ Program completed successfully');
