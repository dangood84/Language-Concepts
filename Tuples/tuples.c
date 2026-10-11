/*
 * Tuples in C
 * C doesn't have native tuples, but we can simulate them with structs
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// ============================================================
// BASIC TUPLE SIMULATION (Structs)
// ============================================================

typedef struct {
    int first;
    int second;
} IntPair;

typedef struct {
    char name[50];
    int age;
    int active;
} PersonTuple;

void demonstrate_basic_tuples() {
    printf("=== Basic Tuples (Structs) ===\n");
    
    IntPair pair = {10, 20};
    printf("Pair: (%d, %d)\n", pair.first, pair.second);
    
    PersonTuple person = {"Alice", 30, 1};
    printf("Person: (%s, %d, %s)\n", person.name, person.age, 
           person.active ? "active" : "inactive");
}

// ============================================================
// GENERIC PAIR (Macro-based)
// ============================================================

#define DEFINE_PAIR(T1, T2, name) \
    typedef struct { \
        T1 first; \
        T2 second; \
    } name

DEFINE_PAIR(int, int, IntIntPair);
DEFINE_PAIR(char*, int, StringIntPair);
DEFINE_PAIR(double, double, DoublePair);

void demonstrate_generic_pairs() {
    printf("\n=== Generic Pairs (Macros) ===\n");
    
    IntIntPair int_pair = {5, 10};
    printf("Int pair: (%d, %d)\n", int_pair.first, int_pair.second);
    
    StringIntPair str_int = {"Alice", 30};
    printf("String-Int pair: (%s, %d)\n", str_int.first, str_int.second);
    
    DoublePair dbl_pair = {3.14, 2.71};
    printf("Double pair: (%.2f, %.2f)\n", dbl_pair.first, dbl_pair.second);
}

// ============================================================
// RETURNING MULTIPLE VALUES
// ============================================================

typedef struct {
    int r;
    int g;
    int b;
} RGB;

RGB get_rgb_color() {
    RGB color = {255, 128, 0};  // Orange
    return color;
}

typedef struct {
    int success;
    char message[100];
} Result;

Result divide_with_error(int a, int b) {
    Result result;
    if (b == 0) {
        result.success = 0;
        strcpy(result.message, "Division by zero");
    } else {
        result.success = 1;
        snprintf(result.message, sizeof(result.message), "%d", a / b);
    }
    return result;
}

void demonstrate_return_values() {
    printf("\n=== Returning Multiple Values ===\n");
    
    RGB color = get_rgb_color();
    printf("RGB: (%d, %d, %d)\n", color.r, color.g, color.b);
    
    Result result1 = divide_with_error(10, 2);
    if (result1.success) {
        printf("Division result: %s\n", result1.message);
    }
    
    Result result2 = divide_with_error(10, 0);
    if (!result2.success) {
        printf("Error: %s\n", result2.message);
    }
}

// ============================================================
// TRIPLE (3-element tuple)
// ============================================================

typedef struct {
    int x;
    int y;
    int z;
} Point3D;

void demonstrate_triple() {
    printf("\n=== Triple (3-element tuple) ===\n");
    
    Point3D point = {10, 20, 30};
    printf("Point3D: (%d, %d, %d)\n", point.x, point.y, point.z);
}

// ============================================================
// ARRAY OF TUPLES
// ============================================================

typedef struct {
    char name[30];
    int grade;
} Student;

void demonstrate_array_of_tuples() {
    printf("\n=== Array of Tuples ===\n");
    
    Student students[] = {
        {"Alice", 95},
        {"Bob", 87},
        {"Charlie", 92}
    };
    
    int count = sizeof(students) / sizeof(students[0]);
    
    printf("Students:\n");
    for (int i = 0; i < count; i++) {
        printf("  %s: %d points\n", students[i].name, students[i].grade);
    }
}

// ============================================================
// SWAP FUNCTION
// ============================================================

IntPair swap_pair(IntPair pair) {
    IntPair swapped = {pair.second, pair.first};
    return swapped;
}

void demonstrate_swap() {
    printf("\n=== Swap Function ===\n");
    
    IntPair original = {10, 20};
    printf("Original: (%d, %d)\n", original.first, original.second);
    
    IntPair swapped = swap_pair(original);
    printf("Swapped: (%d, %d)\n", swapped.first, swapped.second);
}

// ============================================================
// COORDINATE SYSTEM
// ============================================================

typedef struct {
    int x;
    int y;
} Point2D;

double distance(Point2D p1, Point2D p2) {
    int dx = p2.x - p1.x;
    int dy = p2.y - p1.y;
    return sqrt(dx * dx + dy * dy);
}

Point2D translate(Point2D p, int dx, int dy) {
    Point2D result = {p.x + dx, p.y + dy};
    return result;
}

void demonstrate_coordinate_system() {
    printf("\n=== Coordinate System ===\n");
    
    Point2D p1 = {0, 0};
    Point2D p2 = {3, 4};
    
    double dist = distance(p1, p2);
    printf("Distance from (%d,%d) to (%d,%d): %.2f\n", 
           p1.x, p1.y, p2.x, p2.y, dist);
    
    Point2D p3 = translate(p1, 10, 20);
    printf("Translated point: (%d, %d)\n", p3.x, p3.y);
}

// ============================================================
// TUPLE COMPARISON
// ============================================================

int point_equals(Point2D p1, Point2D p2) {
    return p1.x == p2.x && p1.y == p2.y;
}

void demonstrate_comparison() {
    printf("\n=== Tuple Comparison ===\n");
    
    Point2D p1 = {10, 20};
    Point2D p2 = {10, 20};
    Point2D p3 = {15, 25};
    
    printf("p1 equals p2: %s\n", point_equals(p1, p2) ? "true" : "false");
    printf("p1 equals p3: %s\n", point_equals(p1, p3) ? "true" : "false");
}

// ============================================================
// DATABASE ROW (Practical Example)
// ============================================================

typedef struct {
    int id;
    char email[50];
    char status[20];
    double balance;
} DatabaseRow;

DatabaseRow fetch_user(int id) {
    DatabaseRow row = {
        id,
        "user@example.com",
        "Active",
        1250.50
    };
    return row;
}

void demonstrate_database_row() {
    printf("\n=== Practical Example: Database Row ===\n");
    
    DatabaseRow row = fetch_user(42);
    printf("User Record:\n");
    printf("  ID: %d\n", row.id);
    printf("  Email: %s\n", row.email);
    printf("  Status: %s\n", row.status);
    printf("  Balance: $%.2f\n", row.balance);
}

// ============================================================
// NESTED TUPLES
// ============================================================

typedef struct {
    int x;
    int y;
} Coordinate;

typedef struct {
    char name[30];
    Coordinate location;
} Place;

void demonstrate_nested_tuples() {
    printf("\n=== Nested Tuples ===\n");
    
    Place place = {"Treasure", {10, 20}};
    printf("Place: %s at (%d, %d)\n", 
           place.name, place.location.x, place.location.y);
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    printf("=== Tuples in C ===\n\n");
    
    demonstrate_basic_tuples();
    demonstrate_generic_pairs();
    demonstrate_return_values();
    demonstrate_triple();
    demonstrate_array_of_tuples();
    demonstrate_swap();
    demonstrate_coordinate_system();
    demonstrate_comparison();
    demonstrate_database_row();
    demonstrate_nested_tuples();
    
    printf("\n💡 C Tuple Simulation:\n");
    printf("   ✓ Use structs to group related data\n");
    printf("   ✓ Use macros for generic pairs\n");
    printf("   ✓ Return structs from functions\n");
    printf("   ✗ No native tuple support\n");
    printf("   ✗ No automatic destructuring\n");
    
    printf("\n✓ Program completed successfully\n");
    return 0;
}
