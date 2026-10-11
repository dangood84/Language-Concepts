/*
 * Enumerations in TypeScript
 * Demonstrates numeric enums, string enums, const enums, and heterogeneous enums
 */

// ============================================================
// NUMERIC ENUMS (Default)
// ============================================================

enum HttpStatus {
    OK = 200,
    CREATED = 201,
    NO_CONTENT = 204,
    BAD_REQUEST = 400,
    UNAUTHORIZED = 401,
    FORBIDDEN = 403,
    NOT_FOUND = 404,
    INTERNAL_ERROR = 500,
    BAD_GATEWAY = 502
}

function httpStatusToString(status: HttpStatus): string {
    switch (status) {
        case HttpStatus.OK: return "200 OK";
        case HttpStatus.CREATED: return "201 Created";
        case HttpStatus.NOT_FOUND: return "404 Not Found";
        case HttpStatus.INTERNAL_ERROR: return "500 Internal Server Error";
        default: return `${status} Unknown`;
    }
}

function isSuccess(status: HttpStatus): boolean {
    return status >= 200 && status < 300;
}

// ============================================================
// STRING ENUMS (Better for debugging)
// ============================================================

enum DayOfWeek {
    MONDAY = "Monday",
    TUESDAY = "Tuesday",
    WEDNESDAY = "Wednesday",
    THURSDAY = "Thursday",
    FRIDAY = "Friday",
    SATURDAY = "Saturday",
    SUNDAY = "Sunday"
}

function isWeekend(day: DayOfWeek): boolean {
    return day === DayOfWeek.SATURDAY || day === DayOfWeek.SUNDAY;
}

// ============================================================
// CONST ENUMS (Inlined at compile time for performance)
// ============================================================

const enum LogLevel {
    DEBUG = "DEBUG",
    INFO = "INFO",
    WARNING = "WARNING",
    ERROR = "ERROR",
    CRITICAL = "CRITICAL"
}

// Const enums are completely removed after compilation
// and their values are inlined

// ============================================================
// ENUM WITH HELPER NAMESPACE (Advanced Pattern)
// ============================================================

enum TrafficLight {
    RED,
    YELLOW,
    GREEN
}

namespace TrafficLight {
    export function getAction(light: TrafficLight): string {
        switch (light) {
            case TrafficLight.RED: return "STOP";
            case TrafficLight.YELLOW: return "PREPARE TO STOP";
            case TrafficLight.GREEN: return "GO";
        }
    }
    
    export function next(light: TrafficLight): TrafficLight {
        return (light + 1) % 3;
    }
}

// ============================================================
// HETEROGENEOUS ENUM (Mixed types - not recommended)
// ============================================================

enum Mixed {
    No = 0,
    Yes = "YES"
}

// ============================================================
// REVERSE MAPPING (Numeric enums only)
// ============================================================

enum Direction {
    UP,      // 0
    DOWN,    // 1
    LEFT,    // 2
    RIGHT    // 3
}

// Reverse mapping allows: Direction[0] === "UP"

// ============================================================
// ENUM AS TYPE
// ============================================================

interface HttpResponse {
    status: HttpStatus;
    body: string;
}

function createResponse(status: HttpStatus, body: string): HttpResponse {
    return { status, body };
}

// ============================================================
// COMPUTED ENUM MEMBERS
// ============================================================

enum FileAccess {
    None = 0,
    Read = 1 << 0,      // 1
    Write = 1 << 1,     // 2
    ReadWrite = Read | Write,  // 3
    Execute = 1 << 2    // 4
}

function hasPermission(access: FileAccess, permission: FileAccess): boolean {
    return (access & permission) === permission;
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

console.log('=== Enumerations in TypeScript ===\n');

// HTTP Status Demo
console.log('--- HTTP Status Codes (Numeric Enum) ---');
let status: HttpStatus = HttpStatus.OK;
console.log(`Status: ${httpStatusToString(status)}`);
console.log(`Status value: ${status}`);
console.log(`Is success: ${isSuccess(status)}`);

status = HttpStatus.NOT_FOUND;
console.log(`\nStatus: ${httpStatusToString(status)}`);
console.log(`Is success: ${isSuccess(status)}`);

// Days of Week Demo
console.log('\n--- Days of Week (String Enum) ---');
for (const day in DayOfWeek) {
    if (isNaN(Number(day))) {  // Skip numeric keys
        const dayValue = DayOfWeek[day as keyof typeof DayOfWeek];
        console.log(`${dayValue}${isWeekend(dayValue) ? ' 🎉 (Weekend!)' : ''}`);
    }
}

// Log Level Demo (Const Enum)
console.log('\n--- Log Levels (Const Enum) ---');
function log(level: LogLevel, message: string): void {
    console.log(`[${level}] ${message}`);
}

log(LogLevel.INFO, "Application started");
log(LogLevel.WARNING, "Low disk space");
log(LogLevel.ERROR, "Connection failed");

// Traffic Light State Machine
console.log('\n--- Traffic Light State Machine ---');
let light: TrafficLight = TrafficLight.RED;
for (let i = 0; i < 5; i++) {
    console.log(`Light: ${TrafficLight[light]} -> Action: ${TrafficLight.getAction(light)}`);
    light = TrafficLight.next(light);
}

// Reverse Mapping Demo
console.log('\n--- Reverse Mapping (Numeric Enums) ---');
console.log(`Direction[0] = ${Direction[0]}`);  // "UP"
console.log(`Direction[2] = ${Direction[2]}`);  // "LEFT"
console.log(`Direction.UP = ${Direction.UP}`);  // 0

// HTTP Response with Enum
console.log('\n--- Enum as Type ---');
const response: HttpResponse = createResponse(HttpStatus.CREATED, '{"id": 123}');
console.log(`Response status: ${httpStatusToString(response.status)}`);
console.log(`Response body: ${response.body}`);

// Bitwise Flags
console.log('\n--- Bitwise Flags (File Permissions) ---');
const myAccess: FileAccess = FileAccess.Read | FileAccess.Write;
console.log(`Access level: ${myAccess}`);
console.log(`Has Read: ${hasPermission(myAccess, FileAccess.Read)}`);
console.log(`Has Write: ${hasPermission(myAccess, FileAccess.Write)}`);
console.log(`Has Execute: ${hasPermission(myAccess, FileAccess.Execute)}`);

// Enum iteration
console.log('\n--- Enum Iteration ---');
console.log('All HTTP Statuses:');
for (const key in HttpStatus) {
    if (isNaN(Number(key))) {
        console.log(`  ${key} = ${HttpStatus[key as keyof typeof HttpStatus]}`);
    }
}

// Type safety demonstration
console.log('\n--- Type Safety ---');
function processDay(day: DayOfWeek): void {
    console.log(`Processing day: ${day}`);
}

processDay(DayOfWeek.MONDAY);  // ✓ Type-safe
// processDay("Monday");        // ✗ Type error (if uncommented)
// processDay(42);              // ✗ Type error (if uncommented)

console.log('\n✓ Program completed successfully');
