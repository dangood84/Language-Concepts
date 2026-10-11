/*
 * Structures in C++
 * Demonstrates structs with methods, constructors, and comparison with classes
 */

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

// ============================================================
// BASIC STRUCT (POD - Plain Old Data)
// ============================================================

struct Point {
    int x;
    int y;
    
    // Structs can have default values (C++11+)
    int z = 0;
};

void demonstrate_basic_struct() {
    std::cout << "=== Basic Struct ===\n";
    
    Point p1 = {10, 20};
    std::cout << "Point: (" << p1.x << ", " << p1.y << ", " << p1.z << ")\n";
    
    // Designated initializers (C++20)
    Point p2 {.x = 5, .y = 15, .z = 25};
    std::cout << "Point with designated initializers: (" << p2.x << ", " << p2.y << ", " << p2.z << ")\n";
}

// ============================================================
// STRUCT WITH METHODS
// ============================================================

struct Rectangle {
    int width;
    int height;
    
    // Constructor
    Rectangle(int w, int h) : width(w), height(h) {}
    
    // Methods
    int area() const {
        return width * height;
    }
    
    int perimeter() const {
        return 2 * (width + height);
    }
    
    void print() const {
        std::cout << "Rectangle(" << width << "x" << height << ")\n";
    }
};

void demonstrate_struct_with_methods() {
    std::cout << "\n=== Struct with Methods ===\n";
    
    Rectangle rect(10, 5);
    rect.print();
    std::cout << "Area: " << rect.area() << "\n";
    std::cout << "Perimeter: " << rect.perimeter() << "\n";
}

// ============================================================
// NESTED STRUCTS
// ============================================================

struct Address {
    std::string street;
    std::string city;
    std::string zipCode;
};

struct Person {
    std::string name;
    int age;
    Address address;
    
    void print() const {
        std::cout << "Name: " << name << ", Age: " << age << "\n";
        std::cout << "Address: " << address.street << ", " 
                  << address.city << " " << address.zipCode << "\n";
    }
};

void demonstrate_nested_structs() {
    std::cout << "\n=== Nested Structs ===\n";
    
    Person person = {
        "Alice Johnson",
        30,
        {"123 Main St", "Springfield", "12345"}
    };
    
    person.print();
}

// ============================================================
// STRUCT VS CLASS (Default Access)
// ============================================================

struct PublicByDefault {
    int x;  // Public by default
};

class PrivateByDefault {
    int x;  // Private by default
public:
    void setX(int value) { x = value; }
    int getX() const { return x; }
};

void demonstrate_struct_vs_class() {
    std::cout << "\n=== Struct vs Class ===\n";
    
    PublicByDefault s;
    s.x = 10;  // OK - public by default
    std::cout << "Struct member: " << s.x << "\n";
    
    PrivateByDefault c;
    // c.x = 10;  // ✗ Error: 'x' is private
    c.setX(20);
    std::cout << "Class member (via getter): " << c.getX() << "\n";
}

// ============================================================
// ARRAY OF STRUCTS
// ============================================================

struct Account {
    int id;
    std::string name;
    double balance;
    
    void print() const {
        std::cout << "  ID: " << id << ", Name: " << name 
                  << ", Balance: $" << balance << "\n";
    }
};

void demonstrate_array_of_structs() {
    std::cout << "\n=== Array of Structs ===\n";
    
    std::vector<Account> accounts = {
        {1001, "Alice", 5000.50},
        {1002, "Bob", 3200.75},
        {1003, "Charlie", 7500.00}
    };
    
    std::cout << "Bank Accounts:\n";
    for (const auto& account : accounts) {
        account.print();
    }
    
    // Sort by balance
    std::sort(accounts.begin(), accounts.end(), 
              [](const Account& a, const Account& b) {
                  return a.balance > b.balance;
              });
    
    std::cout << "\nSorted by balance (descending):\n";
    for (const auto& account : accounts) {
        account.print();
    }
}

// ============================================================
// STRUCT WITH OPERATOR OVERLOADING
// ============================================================

struct Vector2D {
    double x, y;
    
    // Constructor
    Vector2D(double x = 0, double y = 0) : x(x), y(y) {}
    
    // Operator overloads
    Vector2D operator+(const Vector2D& other) const {
        return {x + other.x, y + other.y};
    }
    
    Vector2D operator-(const Vector2D& other) const {
        return {x - other.x, y - other.y};
    }
    
    Vector2D operator*(double scalar) const {
        return {x * scalar, y * scalar};
    }
    
    bool operator==(const Vector2D& other) const {
        return x == other.x && y == other.y;
    }
    
    void print() const {
        std::cout << "(" << x << ", " << y << ")";
    }
};

void demonstrate_operator_overloading() {
    std::cout << "\n=== Struct with Operator Overloading ===\n";
    
    Vector2D v1(3, 4);
    Vector2D v2(1, 2);
    
    std::cout << "v1: "; v1.print(); std::cout << "\n";
    std::cout << "v2: "; v2.print(); std::cout << "\n";
    
    Vector2D sum = v1 + v2;
    std::cout << "v1 + v2: "; sum.print(); std::cout << "\n";
    
    Vector2D diff = v1 - v2;
    std::cout << "v1 - v2: "; diff.print(); std::cout << "\n";
    
    Vector2D scaled = v1 * 2;
    std::cout << "v1 * 2: "; scaled.print(); std::cout << "\n";
}

// ============================================================
// STRUCT WITH CONSTRUCTOR AND DESTRUCTOR
// ============================================================

struct Resource {
    std::string name;
    
    Resource(const std::string& n) : name(n) {
        std::cout << "✓ Resource '" << name << "' created\n";
    }
    
    ~Resource() {
        std::cout << "✓ Resource '" << name << "' destroyed\n";
    }
    
    // Copy constructor
    Resource(const Resource& other) : name(other.name + " (copy)") {
        std::cout << "✓ Resource '" << name << "' copied\n";
    }
};

void demonstrate_lifecycle() {
    std::cout << "\n=== Struct Lifecycle ===\n";
    
    Resource r1("Resource1");
    Resource r2 = r1;  // Copy constructor
    
    std::cout << "Exiting scope...\n";
}

// ============================================================
// MEMORY LAYOUT
// ============================================================

struct Compact {
    int a;      // 4 bytes
    int b;      // 4 bytes
    int c;      // 4 bytes
};  // Total: 12 bytes

struct Padded {
    char a;     // 1 byte + 3 bytes padding
    int b;      // 4 bytes
    char c;     // 1 byte + 3 bytes padding
};  // Total: 12 bytes (with padding)

#pragma pack(push, 1)
struct Packed {
    char a;     // 1 byte
    int b;      // 4 bytes
    char c;     // 1 byte
};  // Total: 6 bytes (no padding)
#pragma pack(pop)

void demonstrate_memory_layout() {
    std::cout << "\n=== Memory Layout ===\n";
    
    std::cout << "sizeof(Compact): " << sizeof(Compact) << " bytes\n";
    std::cout << "sizeof(Padded): " << sizeof(Padded) << " bytes\n";
    std::cout << "sizeof(Packed): " << sizeof(Packed) << " bytes\n";
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    std::cout << "=== Structures in C++ ===\n\n";
    
    demonstrate_basic_struct();
    demonstrate_struct_with_methods();
    demonstrate_nested_structs();
    demonstrate_struct_vs_class();
    demonstrate_array_of_structs();
    demonstrate_operator_overloading();
    demonstrate_lifecycle();
    demonstrate_memory_layout();
    
    std::cout << "\n💡 C++ Struct vs Class:\n";
    std::cout << "   - Struct: public by default, use for simple data\n";
    std::cout << "   - Class: private by default, use for encapsulation\n";
    std::cout << "   - Both can have methods, constructors, inheritance\n";
    
    std::cout << "\n✓ Program completed successfully\n";
    return 0;
}
