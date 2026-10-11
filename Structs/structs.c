/*
 * Structures in C
 * Demonstrates struct definition, initialization, nesting, and practical uses
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// ============================================================
// BASIC STRUCT DEFINITION
// ============================================================

struct Point {
    int x;
    int y;
};

// typedef for cleaner syntax
typedef struct {
    float x;
    float y;
    float z;
} Point3D;

void demonstrate_basic_structs() {
    printf("=== Basic Structures ===\n");
    
    // Declaration and initialization
    struct Point p1 = {10, 20};
    printf("Point p1: (%d, %d)\n", p1.x, p1.y);
    
    // Designated initializers (C99+)
    struct Point p2 = {.y = 50, .x = 30};
    printf("Point p2: (%d, %d)\n", p2.x, p2.y);
    
    // With typedef
    Point3D p3d = {1.5, 2.5, 3.5};
    printf("Point3D: (%.1f, %.1f, %.1f)\n", p3d.x, p3d.y, p3d.z);
}

// ============================================================
// NESTED STRUCTS
// ============================================================

typedef struct {
    char street[100];
    char city[50];
    char zipCode[10];
} Address;

typedef struct {
    char name[50];
    int age;
    Address address;  // Nested struct
} Person;

void demonstrate_nested_structs() {
    printf("\n=== Nested Structures ===\n");
    
    Person person = {
        .name = "Alice Johnson",
        .age = 30,
        .address = {
            .street = "123 Main St",
            .city = "Springfield",
            .zipCode = "12345"
        }
    };
    
    printf("Name: %s\n", person.name);
    printf("Age: %d\n", person.age);
    printf("Address: %s, %s %s\n", 
           person.address.street, 
           person.address.city, 
           person.address.zipCode);
}

// ============================================================
// ARRAY OF STRUCTS
// ============================================================

typedef struct {
    int id;
    char name[50];
    double balance;
} Account;

void demonstrate_array_of_structs() {
    printf("\n=== Array of Structures ===\n");
    
    Account accounts[] = {
        {1001, "Alice", 5000.50},
        {1002, "Bob", 3200.75},
        {1003, "Charlie", 7500.00}
    };
    
    int count = sizeof(accounts) / sizeof(accounts[0]);
    
    printf("Bank Accounts:\n");
    for (int i = 0; i < count; i++) {
        printf("  ID: %d, Name: %s, Balance: $%.2f\n",
               accounts[i].id, accounts[i].name, accounts[i].balance);
    }
}

// ============================================================
// PASSING STRUCTS TO FUNCTIONS
// ============================================================

// Pass by value (copy)
void print_point(struct Point p) {
    printf("Point: (%d, %d)\n", p.x, p.y);
}

// Pass by pointer (efficient for large structs)
void move_point(struct Point *p, int dx, int dy) {
    p->x += dx;
    p->y += dy;
}

void demonstrate_function_passing() {
    printf("\n=== Passing Structs to Functions ===\n");
    
    struct Point p = {5, 10};
    
    print_point(p);
    
    move_point(&p, 3, 7);
    printf("After move_point(3, 7): ");
    print_point(p);
}

// ============================================================
// DYNAMIC STRUCT ALLOCATION
// ============================================================

void demonstrate_dynamic_allocation() {
    printf("\n=== Dynamic Struct Allocation ===\n");
    
    Person *person = (Person*)malloc(sizeof(Person));
    if (person == NULL) {
        printf("❌ Memory allocation failed\n");
        return;
    }
    
    strcpy(person->name, "Bob Smith");
    person->age = 35;
    strcpy(person->address.street, "456 Elm St");
    strcpy(person->address.city, "Portland");
    strcpy(person->address.zipCode, "97201");
    
    printf("Dynamically allocated person:\n");
    printf("  Name: %s\n", person->name);
    printf("  Age: %d\n", person->age);
    
    free(person);
    printf("✓ Memory freed\n");
}

// ============================================================
// STRUCT WITH FUNCTION POINTERS (OOP Pattern)
// ============================================================

typedef struct Rectangle {
    int width;
    int height;
    int (*area)(struct Rectangle*);
    int (*perimeter)(struct Rectangle*);
} Rectangle;

int rectangle_area(Rectangle *r) {
    return r->width * r->height;
}

int rectangle_perimeter(Rectangle *r) {
    return 2 * (r->width + r->height);
}

Rectangle create_rectangle(int width, int height) {
    Rectangle r = {
        .width = width,
        .height = height,
        .area = rectangle_area,
        .perimeter = rectangle_perimeter
    };
    return r;
}

void demonstrate_struct_with_functions() {
    printf("\n=== Struct with Function Pointers ===\n");
    
    Rectangle rect = create_rectangle(10, 5);
    printf("Rectangle: %dx%d\n", rect.width, rect.height);
    printf("Area: %d\n", rect.area(&rect));
    printf("Perimeter: %d\n", rect.perimeter(&rect));
}

// ============================================================
// MEMORY LAYOUT AND PADDING
// ============================================================

typedef struct {
    char c;      // 1 byte
    int i;       // 4 bytes (but may be padded)
    short s;     // 2 bytes
} PaddedStruct;

typedef struct {
    int i;       // 4 bytes
    char c;      // 1 byte
    short s;     // 2 bytes
} CompactStruct;

void demonstrate_memory_layout() {
    printf("\n=== Memory Layout and Padding ===\n");
    
    printf("sizeof(char): %zu\n", sizeof(char));
    printf("sizeof(short): %zu\n", sizeof(short));
    printf("sizeof(int): %zu\n", sizeof(int));
    printf("\nPaddedStruct size: %zu bytes (may have padding)\n", sizeof(PaddedStruct));
    printf("CompactStruct size: %zu bytes (better aligned)\n", sizeof(CompactStruct));
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    printf("=== Structures in C ===\n\n");
    
    demonstrate_basic_structs();
    demonstrate_nested_structs();
    demonstrate_array_of_structs();
    demonstrate_function_passing();
    demonstrate_dynamic_allocation();
    demonstrate_struct_with_functions();
    demonstrate_memory_layout();
    
    printf("\n✓ Program completed successfully\n");
    return 0;
}
