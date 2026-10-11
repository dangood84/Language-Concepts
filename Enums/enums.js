/*
 * Enums in JavaScript
 * JavaScript doesn't have native enums, but we can simulate them with objects
 */

// ============================================================
// BASIC ENUM SIMULATION (Object with frozen properties)
// ============================================================

const HttpStatus = Object.freeze({
    OK: 200,
    CREATED: 201,
    BAD_REQUEST: 400,
    UNAUTHORIZED: 401,
    NOT_FOUND: 404,
    INTERNAL_SERVER_ERROR: 500
});

function demonstrateBasicEnum() {
    console.log('=== Basic Enum (Frozen Object) ===');
    
    console.log(`HTTP OK: ${HttpStatus.OK}`);
    console.log(`HTTP Not Found: ${HttpStatus.NOT_FOUND}`);
    
    // Attempting to modify (will fail silently or throw in strict mode)
    HttpStatus.OK = 999;  // No effect
    console.log(`HTTP OK after attempt to modify: ${HttpStatus.OK}`);
}

// ============================================================
// STRING ENUMS
// ============================================================

const DayOfWeek = Object.freeze({
    MONDAY: 'Monday',
    TUESDAY: 'Tuesday',
    WEDNESDAY: 'Wednesday',
    THURSDAY: 'Thursday',
    FRIDAY: 'Friday',
    SATURDAY: 'Saturday',
    SUNDAY: 'Sunday'
});

function demonstrateStringEnum() {
    console.log('\n=== String Enum ===');
    
    const today = DayOfWeek.WEDNESDAY;
    console.log(`Today is: ${today}`);
    
    if (today === DayOfWeek.WEDNESDAY) {
        console.log('It\'s the middle of the week!');
    }
}

// ============================================================
// ENUM WITH METHODS (Class-based approach)
// ============================================================

class TrafficLight {
    static RED = new TrafficLight('RED', 'Stop');
    static YELLOW = new TrafficLight('YELLOW', 'Caution');
    static GREEN = new TrafficLight('GREEN', 'Go');
    
    constructor(name, action) {
        this.name = name;
        this.action = action;
    }
    
    getAction() {
        return this.action;
    }
    
    next() {
        switch (this) {
            case TrafficLight.RED:
                return TrafficLight.GREEN;
            case TrafficLight.YELLOW:
                return TrafficLight.RED;
            case TrafficLight.GREEN:
                return TrafficLight.YELLOW;
        }
    }
    
    static values() {
        return [TrafficLight.RED, TrafficLight.YELLOW, TrafficLight.GREEN];
    }
}

function demonstrateEnumWithMethods() {
    console.log('\n=== Enum with Methods (Class-based) ===');
    
    let light = TrafficLight.RED;
    console.log(`Current light: ${light.name} - ${light.getAction()}`);
    
    light = light.next();
    console.log(`Next light: ${light.name} - ${light.getAction()}`);
    
    console.log('\nAll traffic lights:');
    TrafficLight.values().forEach(l => {
        console.log(`  ${l.name}: ${l.getAction()}`);
    });
}

// ============================================================
// REVERSE MAPPING (Enum to name)
// ============================================================

function createBidirectionalEnum(obj) {
    const enumObj = { ...obj };
    Object.keys(obj).forEach(key => {
        enumObj[obj[key]] = key;
    });
    return Object.freeze(enumObj);
}

const Priority = createBidirectionalEnum({
    LOW: 1,
    MEDIUM: 2,
    HIGH: 3,
    CRITICAL: 4
});

function demonstrateReverseMapping() {
    console.log('\n=== Reverse Mapping ===');
    
    console.log(`Priority.HIGH: ${Priority.HIGH}`);
    console.log(`Priority[3]: ${Priority[3]}`);
    
    const priority = Priority.MEDIUM;
    console.log(`Priority value: ${priority}, Name: ${Priority[priority]}`);
}

// ============================================================
// BIT FLAGS (Bitwise operations)
// ============================================================

const FileAccess = Object.freeze({
    NONE: 0,
    READ: 1 << 0,   // 1
    WRITE: 1 << 1,  // 2
    EXECUTE: 1 << 2 // 4
});

function demonstrateBitFlags() {
    console.log('\n=== Bit Flags ===');
    
    // Combine flags
    const readWrite = FileAccess.READ | FileAccess.WRITE;
    console.log(`Read + Write: ${readWrite}`);
    
    // Check if flag is set
    const hasRead = (readWrite & FileAccess.READ) !== 0;
    const hasExecute = (readWrite & FileAccess.EXECUTE) !== 0;
    console.log(`Has READ: ${hasRead}`);
    console.log(`Has EXECUTE: ${hasExecute}`);
}

// ============================================================
// ENUM HELPER FUNCTIONS
// ============================================================

function getEnumKeys(enumObj) {
    return Object.keys(enumObj);
}

function getEnumValues(enumObj) {
    return Object.values(enumObj);
}

function isValidEnumValue(enumObj, value) {
    return Object.values(enumObj).includes(value);
}

function demonstrateHelperFunctions() {
    console.log('\n=== Enum Helper Functions ===');
    
    console.log('HttpStatus keys:', getEnumKeys(HttpStatus));
    console.log('HttpStatus values:', getEnumValues(HttpStatus));
    console.log('Is 200 valid?', isValidEnumValue(HttpStatus, 200));
    console.log('Is 999 valid?', isValidEnumValue(HttpStatus, 999));
}

// ============================================================
// PRACTICAL EXAMPLE: API Response Handler
// ============================================================

const ApiStatus = Object.freeze({
    SUCCESS: 'success',
    ERROR: 'error',
    LOADING: 'loading',
    IDLE: 'idle'
});

class ApiResponse {
    constructor(status, data = null, error = null) {
        this.status = status;
        this.data = data;
        this.error = error;
    }
    
    isSuccess() {
        return this.status === ApiStatus.SUCCESS;
    }
    
    isError() {
        return this.status === ApiStatus.ERROR;
    }
}

function demonstrateApiExample() {
    console.log('\n=== Practical Example: API Response ===');
    
    const successResponse = new ApiResponse(ApiStatus.SUCCESS, { id: 1, name: 'Alice' });
    console.log('Success response:', successResponse.isSuccess());
    console.log('Data:', successResponse.data);
    
    const errorResponse = new ApiResponse(ApiStatus.ERROR, null, 'Network timeout');
    console.log('Error response:', errorResponse.isError());
    console.log('Error:', errorResponse.error);
}

// ============================================================
// SYMBOL-BASED ENUM (Unique values)
// ============================================================

const Direction = Object.freeze({
    UP: Symbol('UP'),
    DOWN: Symbol('DOWN'),
    LEFT: Symbol('LEFT'),
    RIGHT: Symbol('RIGHT')
});

function demonstrateSymbolEnum() {
    console.log('\n=== Symbol-based Enum ===');
    
    const currentDirection = Direction.UP;
    
    switch (currentDirection) {
        case Direction.UP:
            console.log('Moving up');
            break;
        case Direction.DOWN:
            console.log('Moving down');
            break;
        case Direction.LEFT:
            console.log('Moving left');
            break;
        case Direction.RIGHT:
            console.log('Moving right');
            break;
    }
    
    console.log('Direction.UP === Direction.UP:', Direction.UP === Direction.UP);
    console.log('Direction.UP === Direction.DOWN:', Direction.UP === Direction.DOWN);
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

console.log('=== Enums in JavaScript ===\n');

demonstrateBasicEnum();
demonstrateStringEnum();
demonstrateEnumWithMethods();
demonstrateReverseMapping();
demonstrateBitFlags();
demonstrateHelperFunctions();
demonstrateApiExample();
demonstrateSymbolEnum();

console.log('\n💡 JavaScript Enum Best Practices:');
console.log('   ✓ Use Object.freeze() to prevent modification');
console.log('   ✓ Use UPPER_SNAKE_CASE for enum keys');
console.log('   ✓ Consider TypeScript for true enum support');
console.log('   ✓ Use Symbol for guaranteed uniqueness');
console.log('   ✗ Don\'t rely on prototype properties');

console.log('\n✓ Program completed successfully');
