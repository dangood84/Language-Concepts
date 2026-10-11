/*
 * Tuples in JavaScript
 * JavaScript doesn't have native tuples, but arrays can serve the same purpose
 */

// ============================================================
// BASIC TUPLES (Arrays)
// ============================================================

function demonstrateBasicTuples() {
    console.log('=== Basic Tuples (Arrays) ===');
    
    // Array as tuple
    const person = ['Alice', 30, true];
    console.log(`Person: (${person[0]}, ${person[1]}, ${person[2]})`);
    
    // Arrays are mutable (not true tuples)
    person[1] = 31;
    console.log(`After modification: (${person[0]}, ${person[1]}, ${person[2]})`);
}

// ============================================================
// DESTRUCTURING
// ============================================================

function demonstrateDestructuring() {
    console.log('\n=== Destructuring ===');
    
    const person = ['Bob', 35, false];
    
    // Destructure into variables
    const [name, age, isActive] = person;
    console.log(`${name} is ${age} years old, Active: ${isActive}`);
    
    // Partial destructuring
    const [firstName] = person;
    console.log(`First name only: ${firstName}`);
    
    // Skip elements
    const [, , active] = person;
    console.log(`Active status: ${active}`);
}

// ============================================================
// RETURNING MULTIPLE VALUES
// ============================================================

function getRgbColor() {
    return [255, 128, 0];  // Orange color
}

function divideWithError(a, b) {
    if (b === 0) {
        return [false, 'Division by zero'];
    }
    return [true, (a / b).toString()];
}

function demonstrateReturnValues() {
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
// OBJECT.FREEZE (Immutable tuple-like)
// ============================================================

function demonstrateImmutableTuple() {
    console.log('\n=== Immutable Tuple (Object.freeze) ===');
    
    const tuple = Object.freeze([10, 20, 30]);
    console.log(`Tuple: [${tuple.join(', ')}]`);
    
    // Attempt to modify (fails silently or throws in strict mode)
    tuple[0] = 99;
    console.log(`After attempted modification: [${tuple.join(', ')}]`);
    console.log('(Modification was blocked by Object.freeze)');
}

// ============================================================
// ARRAY OF TUPLES
// ============================================================

function demonstrateArrayOfTuples() {
    console.log('\n=== Array of Tuples ===');
    
    const students = [
        ['Alice', 95],
        ['Bob', 87],
        ['Charlie', 92]
    ];
    
    console.log('Students:');
    students.forEach(([name, grade]) => {
        console.log(`  ${name}: ${grade} points`);
    });
    
    // Sort by grade (descending)
    const sorted = [...students].sort((a, b) => b[1] - a[1]);
    console.log('\nSorted by grade:');
    sorted.forEach(([name, grade]) => {
        console.log(`  ${name}: ${grade} points`);
    });
}

// ============================================================
// SWAP FUNCTION
// ============================================================

function swap([a, b]) {
    return [b, a];
}

function demonstrateSwap() {
    console.log('\n=== Swap Function ===');
    
    const original = ['Alice', 30];
    console.log(`Original: [${original.join(', ')}]`);
    
    const swapped = swap(original);
    console.log(`Swapped: [${swapped.join(', ')}]`);
}

// ============================================================
// COORDINATE SYSTEM
// ============================================================

function distance([x1, y1], [x2, y2]) {
    return Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
}

function translate([x, y], dx, dy) {
    return [x + dx, y + dy];
}

function demonstrateCoordinateSystem() {
    console.log('\n=== Coordinate System ===');
    
    const p1 = [0, 0];
    const p2 = [3, 4];
    
    const dist = distance(p1, p2);
    console.log(`Distance from (${p1[0]},${p1[1]}) to (${p2[0]},${p2[1]}): ${dist}`);
    
    const p3 = translate(p1, 10, 20);
    console.log(`Translated point: (${p3[0]}, ${p3[1]})`);
}

// ============================================================
// TUPLE COMPARISON
// ============================================================

function tupleEquals(t1, t2) {
    if (t1.length !== t2.length) return false;
    return t1.every((val, idx) => val === t2[idx]);
}

function demonstrateComparison() {
    console.log('\n=== Tuple Comparison ===');
    
    const t1 = [10, 20];
    const t2 = [10, 20];
    const t3 = [15, 25];
    
    console.log(`t1 equals t2: ${tupleEquals(t1, t2)}`);
    console.log(`t1 equals t3: ${tupleEquals(t1, t3)}`);
    
    // Reference comparison
    console.log(`t1 === t2 (reference): ${t1 === t2}`);
}

// ============================================================
// DATABASE ROW (Practical Example)
// ============================================================

function fetchUser(id) {
    return [id, 'user@example.com', 'Active', 1250.50];
}

function demonstrateDatabaseRow() {
    console.log('\n=== Practical Example: Database Row ===');
    
    const [id, email, status, balance] = fetchUser(42);
    console.log('User Record:');
    console.log(`  ID: ${id}`);
    console.log(`  Email: ${email}`);
    console.log(`  Status: ${status}`);
    console.log(`  Balance: $${balance}`);
}

// ============================================================
// NESTED TUPLES
// ============================================================

function demonstrateNestedTuples() {
    console.log('\n=== Nested Tuples ===');
    
    const person = ['Alice', [30, 'alice@example.com']];
    const [name, [age, email]] = person;
    console.log(`Name: ${name}, Age: ${age}, Email: ${email}`);
}

// ============================================================
// REST ELEMENTS
// ============================================================

function demonstrateRestElements() {
    console.log('\n=== Rest Elements ===');
    
    const tuple = ['first', 'second', 1, 2, 3, 4];
    const [str1, str2, ...numbers] = tuple;
    
    console.log(`Strings: ${str1}, ${str2}`);
    console.log(`Numbers: [${numbers.join(', ')}]`);
}

// ============================================================
// TUPLE AS MAP KEY (Using JSON stringify)
// ============================================================

function demonstrateTupleAsKey() {
    console.log('\n=== Tuple as Map Key ===');
    
    const map = new Map();
    
    const point = [10, 20];
    const key = JSON.stringify(point);
    map.set(key, 'Treasure');
    
    const lookupKey = JSON.stringify([10, 20]);
    console.log(`Value at (10, 20): ${map.get(lookupKey)}`);
}

// ============================================================
// TUPLE WITH FUNCTIONS
// ============================================================

function demonstrateTupleWithFunction() {
    console.log('\n=== Tuple with Function ===');
    
    const operations = [
        ['Double', x => x * 2],
        ['Square', x => x * x],
        ['Add 10', x => x + 10]
    ];
    
    const input = 5;
    console.log(`Input: ${input}`);
    
    operations.forEach(([name, fn]) => {
        console.log(`  ${name}: ${fn(input)}`);
    });
}

// ============================================================
// SPREAD OPERATOR (Copy/Concat)
// ============================================================

function demonstrateSpreadOperator() {
    console.log('\n=== Spread Operator ===');
    
    const tuple1 = [1, 2];
    const tuple2 = [3, 4];
    
    const combined = [...tuple1, ...tuple2];
    console.log(`Combined: [${combined.join(', ')}]`);
    
    const copy = [...tuple1];
    console.log(`Copy: [${copy.join(', ')}]`);
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

console.log('=== Tuples in JavaScript ===\n');

demonstrateBasicTuples();
demonstrateDestructuring();
demonstrateReturnValues();
demonstrateImmutableTuple();
demonstrateArrayOfTuples();
demonstrateSwap();
demonstrateCoordinateSystem();
demonstrateComparison();
demonstrateDatabaseRow();
demonstrateNestedTuples();
demonstrateRestElements();
demonstrateTupleAsKey();
demonstrateTupleWithFunction();
demonstrateSpreadOperator();

console.log('\n💡 JavaScript Tuple Simulation:');
console.log('   ✓ Use arrays for tuple-like behavior');
console.log('   ✓ Use destructuring for cleaner code');
console.log('   ✓ Use Object.freeze for immutability');
console.log('   ✓ Consider TypeScript for type-safe tuples');
console.log('   ✗ Arrays are mutable (not true tuples)');
console.log('   ✗ No compile-time length/type checking');

console.log('\n✓ Program completed successfully');
