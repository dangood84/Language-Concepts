/*
 * Enums in C++
 * Demonstrates traditional enums and modern enum class (C++11+)
 */

#include <iostream>
#include <string>
#include <map>

// ============================================================
// TRADITIONAL C-STYLE ENUMS (Unscoped)
// ============================================================

enum Color {
    RED,      // 0
    GREEN,    // 1
    BLUE      // 2
};

enum Status {
    PENDING = 100,
    ACTIVE = 200,
    INACTIVE = 300
};

void demonstrate_traditional_enums() {
    std::cout << "=== Traditional C-Style Enums ===\n";
    
    Color c = RED;
    std::cout << "Color RED value: " << c << "\n";
    
    // Problem: Implicit conversion to int
    int x = GREEN;  // This works but can be dangerous
    std::cout << "GREEN as int: " << x << "\n";
    
    // Problem: No scope - can cause name conflicts
    // enum Signal { RED, YELLOW, GREEN };  // ✗ Error: RED and GREEN already defined
}

// ============================================================
// ENUM CLASS (C++11) - Scoped and Type-Safe
// ============================================================

enum class HttpStatus {
    OK = 200,
    CREATED = 201,
    BAD_REQUEST = 400,
    UNAUTHORIZED = 401,
    NOT_FOUND = 404,
    INTERNAL_SERVER_ERROR = 500
};

enum class DayOfWeek {
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY
};

void demonstrate_enum_class() {
    std::cout << "\n=== Enum Class (C++11) ===\n";
    
    HttpStatus status = HttpStatus::OK;
    
    // Must use scope resolution
    std::cout << "Status: " << static_cast<int>(status) << "\n";
    
    // Type safety: no implicit conversion
    // int x = status;  // ✗ Error: cannot convert enum class to int
    int x = static_cast<int>(status);  // Must be explicit
    std::cout << "Status as int: " << x << "\n";
    
    // Scoped: no name conflicts
    DayOfWeek today = DayOfWeek::WEDNESDAY;
    std::cout << "Today: " << static_cast<int>(today) << "\n";
}

// ============================================================
// ENUM TO STRING CONVERSION
// ============================================================

std::string httpStatusToString(HttpStatus status) {
    switch (status) {
        case HttpStatus::OK: return "200 OK";
        case HttpStatus::CREATED: return "201 Created";
        case HttpStatus::BAD_REQUEST: return "400 Bad Request";
        case HttpStatus::UNAUTHORIZED: return "401 Unauthorized";
        case HttpStatus::NOT_FOUND: return "404 Not Found";
        case HttpStatus::INTERNAL_SERVER_ERROR: return "500 Internal Server Error";
        default: return "Unknown Status";
    }
}

std::string dayToString(DayOfWeek day) {
    switch (day) {
        case DayOfWeek::MONDAY: return "Monday";
        case DayOfWeek::TUESDAY: return "Tuesday";
        case DayOfWeek::WEDNESDAY: return "Wednesday";
        case DayOfWeek::THURSDAY: return "Thursday";
        case DayOfWeek::FRIDAY: return "Friday";
        case DayOfWeek::SATURDAY: return "Saturday";
        case DayOfWeek::SUNDAY: return "Sunday";
        default: return "Unknown Day";
    }
}

void demonstrate_enum_to_string() {
    std::cout << "\n=== Enum to String Conversion ===\n";
    
    HttpStatus status = HttpStatus::NOT_FOUND;
    std::cout << "HTTP Status: " << httpStatusToString(status) << "\n";
    
    DayOfWeek day = DayOfWeek::FRIDAY;
    std::cout << "Day: " << dayToString(day) << "\n";
}

// ============================================================
// ENUM CLASS WITH UNDERLYING TYPE
// ============================================================

enum class Priority : unsigned char {
    LOW = 1,
    MEDIUM = 2,
    HIGH = 3,
    CRITICAL = 4
};

void demonstrate_underlying_type() {
    std::cout << "\n=== Enum with Underlying Type ===\n";
    
    Priority p = Priority::HIGH;
    std::cout << "Priority: " << static_cast<int>(p) << "\n";
    std::cout << "Size of Priority: " << sizeof(Priority) << " bytes\n";
    std::cout << "Size of int: " << sizeof(int) << " bytes\n";
}

// ============================================================
// BITWISE FLAGS (enum class)
// ============================================================

enum class FileAccess : unsigned int {
    NONE = 0,
    READ = 1 << 0,   // 1
    WRITE = 1 << 1,  // 2
    EXECUTE = 1 << 2 // 4
};

// Operator overloading for bitwise operations
FileAccess operator|(FileAccess a, FileAccess b) {
    return static_cast<FileAccess>(
        static_cast<unsigned int>(a) | static_cast<unsigned int>(b)
    );
}

FileAccess operator&(FileAccess a, FileAccess b) {
    return static_cast<FileAccess>(
        static_cast<unsigned int>(a) & static_cast<unsigned int>(b)
    );
}

bool hasFlag(FileAccess value, FileAccess flag) {
    return (static_cast<unsigned int>(value) & static_cast<unsigned int>(flag)) != 0;
}

void demonstrate_bit_flags() {
    std::cout << "\n=== Bitwise Flags ===\n";
    
    FileAccess readWrite = FileAccess::READ | FileAccess::WRITE;
    std::cout << "Read + Write: " << static_cast<int>(readWrite) << "\n";
    
    std::cout << "Has READ: " << (hasFlag(readWrite, FileAccess::READ) ? "Yes" : "No") << "\n";
    std::cout << "Has EXECUTE: " << (hasFlag(readWrite, FileAccess::EXECUTE) ? "Yes" : "No") << "\n";
}

// ============================================================
// ENUM CLASS IN SWITCH STATEMENTS
// ============================================================

enum class TrafficLight {
    RED,
    YELLOW,
    GREEN
};

std::string getAction(TrafficLight light) {
    switch (light) {
        case TrafficLight::RED:
            return "Stop";
        case TrafficLight::YELLOW:
            return "Caution";
        case TrafficLight::GREEN:
            return "Go";
        // Compiler warning if you forget a case (with -Wall)
    }
    return "Unknown";
}

void demonstrate_switch_statement() {
    std::cout << "\n=== Enum in Switch Statement ===\n";
    
    TrafficLight light = TrafficLight::RED;
    std::cout << "Red light: " << getAction(light) << "\n";
    
    light = TrafficLight::GREEN;
    std::cout << "Green light: " << getAction(light) << "\n";
}

// ============================================================
// ENUM CLASS WITH MAP (String Lookup)
// ============================================================

void demonstrate_enum_map() {
    std::cout << "\n=== Enum with Map ===\n";
    
    std::map<HttpStatus, std::string> statusMessages = {
        {HttpStatus::OK, "Request successful"},
        {HttpStatus::NOT_FOUND, "Resource not found"},
        {HttpStatus::INTERNAL_SERVER_ERROR, "Server error occurred"}
    };
    
    HttpStatus status = HttpStatus::NOT_FOUND;
    std::cout << "Status message: " << statusMessages[status] << "\n";
}

// ============================================================
// PRACTICAL EXAMPLE: State Machine
// ============================================================

enum class ConnectionState {
    DISCONNECTED,
    CONNECTING,
    CONNECTED,
    DISCONNECTING,
    ERROR
};

class Connection {
private:
    ConnectionState state;
    
public:
    Connection() : state(ConnectionState::DISCONNECTED) {}
    
    void connect() {
        if (state == ConnectionState::DISCONNECTED) {
            state = ConnectionState::CONNECTING;
            std::cout << "Connecting...\n";
            state = ConnectionState::CONNECTED;
            std::cout << "Connected!\n";
        } else {
            std::cout << "Already connected or connecting\n";
        }
    }
    
    void disconnect() {
        if (state == ConnectionState::CONNECTED) {
            state = ConnectionState::DISCONNECTING;
            std::cout << "Disconnecting...\n";
            state = ConnectionState::DISCONNECTED;
            std::cout << "Disconnected!\n";
        } else {
            std::cout << "Not connected\n";
        }
    }
    
    ConnectionState getState() const { return state; }
};

void demonstrate_state_machine() {
    std::cout << "\n=== Practical Example: State Machine ===\n";
    
    Connection conn;
    conn.connect();
    conn.disconnect();
}

// ============================================================
// COMPARISON: C enum vs C++ enum class
// ============================================================

void demonstrate_comparison() {
    std::cout << "\n=== C enum vs C++ enum class ===\n";
    
    // Traditional enum (C-style)
    enum OldColor { OLD_RED, OLD_GREEN, OLD_BLUE };
    OldColor oldColor = OLD_RED;
    int x = oldColor;  // Implicit conversion
    std::cout << "Traditional enum - implicit conversion: " << x << "\n";
    
    // Modern enum class (C++11)
    enum class NewColor { RED, GREEN, BLUE };
    NewColor newColor = NewColor::RED;
    // int y = newColor;  // ✗ Error: no implicit conversion
    int y = static_cast<int>(newColor);  // Must be explicit
    std::cout << "Enum class - explicit conversion: " << y << "\n";
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    std::cout << "=== Enums in C++ ===\n\n";
    
    demonstrate_traditional_enums();
    demonstrate_enum_class();
    demonstrate_enum_to_string();
    demonstrate_underlying_type();
    demonstrate_bit_flags();
    demonstrate_switch_statement();
    demonstrate_enum_map();
    demonstrate_state_machine();
    demonstrate_comparison();
    
    std::cout << "\n💡 C++ Enum Best Practices:\n";
    std::cout << "   ✓ Prefer enum class over traditional enums\n";
    std::cout << "   ✓ Use enum class for type safety and scoping\n";
    std::cout << "   ✓ Specify underlying type for memory optimization\n";
    std::cout << "   ✓ Overload operators for bitwise flag operations\n";
    std::cout << "   ✗ Avoid mixing enum class with integers\n";
    
    std::cout << "\n✓ Program completed successfully\n";
    return 0;
}
