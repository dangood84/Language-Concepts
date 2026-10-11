/*
 * Tuples in TypeScript
 * Demonstrates native tuple types with type safety and destructuring
 */

// ============================================================
// BASIC TUPLE TYPES
// ============================================================

function demonstrateBasicTuples(): void {
    console.log('=== Basic Tuples ===');
    
    // Fixed-length, ordered, heterogeneous types
    let person: [string, number, boolean] = ['Alice', 30, true];
    
    console.log(`Name: ${person[0]}`);
    console.log(`Age: ${person[1]}`);
    console.log(`Active: ${person[2]}`);
    
    // Type safety: TypeScript knows the type at each position
    let name: string = person[0];  // OK
    let age: number = person[1];   // OK
    // let error: string = person[1];  // ✗ Error: Type 'number' is not assignable to type 'string'
}

// ============================================================
// DESTRUCTURING
// ============================================================

function demonstrateDestructuring(): void {
    console.log('\n=== Destructuring ===');
    
    let person: [string, number, boolean] = ['Bob', 35, false];
    
    // Destructure into separate variables
    let [name, age, isActive] = person;
    console.log(`${name} is ${age} years old, Active: ${isActive}`);
    
    // Partial destructuring (ignore elements)
    let [firstName] = person;
    console.log(`First name only: ${firstName}`);
    
    // Skip elements
    let [, , active] = person;
    console.log(`Active status: ${active}`);
}

// ============================================================
// RETURNING MULTIPLE VALUES
// ============================================================

function getRgbColor(): [number, number, number] {
    return [255, 128, 0];  // Orange color
}

function divideWithError(a: number, b: number): [boolean, string] {
    if (b === 0) {
        return [false, 'Division by zero'];
    }
    return [true, (a / b).toString()];
}

function demonstrateReturnValues(): void {
    console.log('\n=== Returning Multiple Values ===');
    
    const [r, g, b] = getRgbColor();
    console.log(`RGB: (${r}, ${g}, ${b})`);
    
    const [success, result] = divideWithError(10, 2);
    if (success) {
        console.log(`Division result: ${result}`);
    }
    
    const [success2, error] = divideWithError(10, 0);
    if (!success2) {
        console.log(`Error: ${error}`);
    }
}

// ============================================================
// READONLY TUPLES
// ============================================================

function demonstrateReadonlyTuples(): void {
    console.log('\n=== Readonly Tuples ===');
    
    const point: readonly [number, number] = [10, 20];
    console.log(`Point: (${point[0]}, ${point[1]})`);
    
    // point[0] = 15;  // ✗ Error: Cannot assign to '0' because it is a read-only property
    // point.push(30);  // ✗ Error: Property 'push' does not exist on type 'readonly [number, number]'
}

// ============================================================
// OPTIONAL ELEMENTS
// ============================================================

function demonstrateOptionalElements(): void {
    console.log('\n=== Optional Elements ===');
    
    type Coordinate = [number, number, number?];  // z is optional
    
    const point2d: Coordinate = [10, 20];
    const point3d: Coordinate = [10, 20, 30];
    
    console.log(`2D Point: (${point2d[0]}, ${point2d[1]})`);
    console.log(`3D Point: (${point3d[0]}, ${point3d[1]}, ${point3d[2]})`);
}

// ============================================================
// REST ELEMENTS
// ============================================================

function demonstrateRestElements(): void {
    console.log('\n=== Rest Elements ===');
    
    type StringNumberBooleans = [string, number, ...boolean[]];
    
    const tuple1: StringNumberBooleans = ['hello', 1];
    const tuple2: StringNumberBooleans = ['world', 2, true, false, true];
    
    console.log(`Tuple 1: ${tuple1.join(', ')}`);
    console.log(`Tuple 2: ${tuple2.join(', ')}`);
}

// ============================================================
// LABELED TUPLE ELEMENTS (TypeScript 4.0+)
// ============================================================

function demonstrateLabeledTuples(): void {
    console.log('\n=== Labeled Tuple Elements ===');
    
    type Person = [name: string, age: number, isActive: boolean];
    
    const person: Person = ['Charlie', 40, true];
    
    // Labels are for documentation; access is still by index
    console.log(`Name: ${person[0]}`);
    console.log(`Age: ${person[1]}`);
    console.log(`Active: ${person[2]}`);
}

// ============================================================
// TUPLE TYPES IN FUNCTIONS
// ============================================================

function processCoordinate([x, y]: [number, number]): void {
    console.log(`Processing coordinate: (${x}, ${y})`);
}

function demonstrateTupleInFunctions(): void {
    console.log('\n=== Tuple Types in Functions ===');
    
    const point: [number, number] = [5, 10];
    processCoordinate(point);
}

// ============================================================
// PRACTICAL EXAMPLE: Database Query Result
// ============================================================

type DatabaseRow = [id: number, email: string, status: string, balance: number];

function fetchUser(id: number): DatabaseRow {
    // Simulated database fetch
    return [id, 'user@example.com', 'Active', 1250.50];
}

function demonstrateDatabaseRow(): void {
    console.log('\n=== Practical Example: Database Row ===');
    
    const row = fetchUser(42);
    const [id, email, status, balance] = row;
    
    console.log('User Record:');
    console.log(`  ID: ${id}`);
    console.log(`  Email: ${email}`);
    console.log(`  Status: ${status}`);
    console.log(`  Balance: $${balance}`);
}

// ============================================================
// TUPLE VS ARRAY
// ============================================================

function demonstrateTupleVsArray(): void {
    console.log('\n=== Tuple vs Array ===');
    
    // Tuple: fixed length, heterogeneous types
    const tuple: [string, number] = ['Alice', 30];
    console.log(`Tuple: ${tuple[0]} (type: string), ${tuple[1]} (type: number)`);
    
    // Array: dynamic length, homogeneous types
    const array: number[] = [1, 2, 3, 4, 5];
    console.log(`Array: ${array.join(', ')}`);
    
    // Tuple length is known at compile time
    console.log(`Tuple length: ${tuple.length}`);
    
    // Array length is dynamic
    array.push(6);
    console.log(`Array length after push: ${array.length}`);
}

// ============================================================
// GENERIC TUPLES
// ============================================================

function swap<T, U>(tuple: [T, U]): [U, T] {
    return [tuple[1], tuple[0]];
}

function demonstrateGenericTuples(): void {
    console.log('\n=== Generic Tuples ===');
    
    const original: [string, number] = ['Alice', 30];
    const swapped = swap(original);
    
    console.log(`Original: [${original[0]}, ${original[1]}]`);
    console.log(`Swapped: [${swapped[0]}, ${swapped[1]}]`);
}

// ============================================================
// TUPLE AS MAP KEY (TypeScript specific)
// ============================================================

function demonstrateTupleAsKey(): void {
    console.log('\n=== Tuple as Map Key ===');
    
    type Point = [number, number];
    const map = new Map<string, string>();
    
    // Tuples need to be stringified to use as keys
    const point: Point = [10, 20];
    const key = JSON.stringify(point);
    
    map.set(key, 'Treasure');
    
    const lookupKey = JSON.stringify([10, 20]);
    console.log(`Value at (10, 20): ${map.get(lookupKey)}`);
}

// ============================================================
// PRACTICAL EXAMPLE: Coordinate System
// ============================================================

type Point2D = [x: number, y: number];
type Point3D = [x: number, y: number, z: number];

function distance2D([x1, y1]: Point2D, [x2, y2]: Point2D): number {
    return Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
}

function demonstrateCoordinateSystem(): void {
    console.log('\n=== Practical Example: Coordinate System ===');
    
    const p1: Point2D = [0, 0];
    const p2: Point2D = [3, 4];
    
    const dist = distance2D(p1, p2);
    console.log(`Distance from (${p1[0]},${p1[1]}) to (${p2[0]},${p2[1]}): ${dist}`);
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

console.log('=== Tuples in TypeScript ===\n');

demonstrateBasicTuples();
demonstrateDestructuring();
demonstrateReturnValues();
demonstrateReadonlyTuples();
demonstrateOptionalElements();
demonstrateRestElements();
demonstrateLabeledTuples();
demonstrateTupleInFunctions();
demonstrateDatabaseRow();
demonstrateTupleVsArray();
demonstrateGenericTuples();
demonstrateTupleAsKey();
demonstrateCoordinateSystem();

console.log('\n💡 TypeScript Tuple Best Practices:');
console.log('   ✓ Use tuples for fixed-length, heterogeneous data');
console.log('   ✓ Use labeled tuples for better documentation');
console.log('   ✓ Use readonly tuples for immutability');
console.log('   ✓ Prefer destructuring for cleaner code');
console.log('   ✗ Don\'t use tuples when a named interface is clearer');
console.log('   ✗ Don\'t use tuples for more than 3-4 elements');

console.log('\n✓ Program completed successfully');
