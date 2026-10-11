/*
 * Tuples in C++
 * Demonstrates std::tuple, std::pair, and structured bindings (C++17+)
 */

#include <iostream>
#include <tuple>
#include <string>
#include <map>

// ============================================================
// BASIC TUPLE USAGE
// ============================================================

void demonstrate_basic_tuples() {
    std::cout << "=== Basic Tuples ===\n";
    
    // Create tuple
    std::tuple<std::string, int, double> person("Alice", 30, 5.6);
    
    // Access elements (C++14+)
    std::cout << "Name: " << std::get<0>(person) << "\n";
    std::cout << "Age: " << std::get<1>(person) << "\n";
    std::cout << "Height: " << std::get<2>(person) << " feet\n";
    
    // Modify element
    std::get<1>(person) = 31;
    std::cout << "Updated age: " << std::get<1>(person) << "\n";
}

// ============================================================
// STRUCTURED BINDINGS (C++17)
// ============================================================

void demonstrate_structured_bindings() {
    std::cout << "\n=== Structured Bindings (C++17) ===\n";
    
    std::tuple<std::string, int, double> person("Bob", 35, 6.0);
    
    // Automatic destructuring
    auto [name, age, height] = person;
    std::cout << name << " is " << age << " years old and " << height << " feet tall\n";
}

// ============================================================
// PAIR (Special 2-element Tuple)
// ============================================================

void demonstrate_pair() {
    std::cout << "\n=== std::pair ===\n";
    
    std::pair<std::string, int> coordinate("x", 100);
    std::cout << "Coordinate: " << coordinate.first << " = " << coordinate.second << "\n";
    
    // Pairs are commonly used in maps
    std::map<std::string, int> ages;
    ages["Alice"] = 30;
    ages["Bob"] = 35;
    
    std::cout << "\nAges (from map):\n";
    for (const auto& [name, age] : ages) {  // Structured binding with pair
        std::cout << "  " << name << ": " << age << "\n";
    }
}

// ============================================================
// RETURNING MULTIPLE VALUES
// ============================================================

std::tuple<int, int, int> get_rgb_color() {
    return {255, 128, 0};  // Orange color
}

std::tuple<bool, std::string> divide_with_error(int a, int b) {
    if (b == 0) {
        return {false, "Division by zero"};
    }
    return {true, std::to_string(a / b)};
}

void demonstrate_return_values() {
    std::cout << "\n=== Returning Multiple Values ===\n";
    
    auto [r, g, b] = get_rgb_color();
    std::cout << "RGB: (" << r << ", " << g << ", " << b << ")\n";
    
    auto [success, result] = divide_with_error(10, 2);
    if (success) {
        std::cout << "Division result: " << result << "\n";
    }
    
    auto [success2, error] = divide_with_error(10, 0);
    if (!success2) {
        std::cout << "Error: " << error << "\n";
    }
}

// ============================================================
// MAKE_TUPLE
// ============================================================

void demonstrate_make_tuple() {
    std::cout << "\n=== std::make_tuple ===\n";
    
    auto person = std::make_tuple("Charlie", 40, true);
    
    auto [name, age, is_active] = person;
    std::cout << "Person: " << name << ", " << age << " years old, Active: " 
              << (is_active ? "Yes" : "No") << "\n";
}

// ============================================================
// TUPLE SIZE AND TYPE
// ============================================================

void demonstrate_tuple_traits() {
    std::cout << "\n=== Tuple Traits ===\n";
    
    using PersonTuple = std::tuple<std::string, int, double>;
    
    std::cout << "Tuple size: " << std::tuple_size<PersonTuple>::value << "\n";
    
    // Get type of element at index 0
    std::tuple_element<0, PersonTuple>::type name = "Test";
    std::cout << "Type of element 0: string (value: " << name << ")\n";
}

// ============================================================
// TIE (Create tuple of references)
// ============================================================

void demonstrate_tie() {
    std::cout << "\n=== std::tie ===\n";
    
    std::string name;
    int age;
    double height;
    
    // Unpack tuple into existing variables
    std::tie(name, age, height) = std::make_tuple("Diana", 28, 5.5);
    std::cout << "Unpacked: " << name << ", " << age << ", " << height << "\n";
    
    // Ignore some elements with std::ignore
    std::tie(name, std::ignore, height) = std::make_tuple("Eve", 32, 5.8);
    std::cout << "With ignore: " << name << ", " << height << " (age ignored)\n";
}

// ============================================================
// TUPLE CONCATENATION
// ============================================================

void demonstrate_tuple_cat() {
    std::cout << "\n=== Tuple Concatenation ===\n";
    
    auto tuple1 = std::make_tuple("John", 45);
    auto tuple2 = std::make_tuple(6.2, true);
    
    auto combined = std::tuple_cat(tuple1, tuple2);
    
    auto [name, age, height, active] = combined;
    std::cout << "Combined: " << name << ", " << age << ", " << height << ", " 
              << (active ? "Active" : "Inactive") << "\n";
}

// ============================================================
// COMPARING TUPLES
// ============================================================

void demonstrate_tuple_comparison() {
    std::cout << "\n=== Tuple Comparison ===\n";
    
    std::tuple<int, int> point1{1, 2};
    std::tuple<int, int> point2{1, 3};
    std::tuple<int, int> point3{1, 2};
    
    std::cout << "point1 < point2: " << (point1 < point2 ? "true" : "false") << "\n";
    std::cout << "point1 == point3: " << (point1 == point3 ? "true" : "false") << "\n";
}

// ============================================================
// PRACTICAL EXAMPLE: Database Row
// ============================================================

using DatabaseRow = std::tuple<int, std::string, std::string, double>;

DatabaseRow fetch_user(int id) {
    // Simulated database fetch
    return {id, "user@example.com", "Active", 1250.50};
}

void demonstrate_database_row() {
    std::cout << "\n=== Practical Example: Database Row ===\n";
    
    auto row = fetch_user(42);
    auto [id, email, status, balance] = row;
    
    std::cout << "User Record:\n";
    std::cout << "  ID: " << id << "\n";
    std::cout << "  Email: " << email << "\n";
    std::cout << "  Status: " << status << "\n";
    std::cout << "  Balance: $" << balance << "\n";
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    std::cout << "=== Tuples in C++ ===\n\n";
    
    demonstrate_basic_tuples();
    demonstrate_structured_bindings();
    demonstrate_pair();
    demonstrate_return_values();
    demonstrate_make_tuple();
    demonstrate_tuple_traits();
    demonstrate_tie();
    demonstrate_tuple_cat();
    demonstrate_tuple_comparison();
    demonstrate_database_row();
    
    std::cout << "\n💡 When to Use Tuples:\n";
    std::cout << "   ✓ Returning multiple values from functions\n";
    std::cout << "   ✓ Quick temporary grouping without custom struct\n";
    std::cout << "   ✓ Generic programming with variadic templates\n";
    std::cout << "   ✗ When data needs descriptive names (use struct)\n";
    std::cout << "   ✗ For complex data with behavior (use classes)\n";
    
    std::cout << "\n✓ Program completed successfully\n";
    return 0;
}
