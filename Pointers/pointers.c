/*
 * Pointers in C
 * Demonstrates pointer basics, dynamic memory, function pointers
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// ============================================================
// BASIC POINTER OPERATIONS
// ============================================================

void demonstrate_basic_pointers() {
    printf("=== Basic Pointer Operations ===\n");
    
    int value = 42;
    int *ptr = &value;  // Pointer to value
    
    printf("Value: %d\n", value);
    printf("Address of value: %p\n", (void*)&value);
    printf("Pointer holds address: %p\n", (void*)ptr);
    printf("Dereferenced pointer (*ptr): %d\n", *ptr);
    
    // Modify through pointer
    *ptr = 100;
    printf("After *ptr = 100, value is: %d\n", value);
    
    // Null pointer
    int *null_ptr = NULL;
    if (null_ptr == NULL) {
        printf("Pointer is NULL (safe check)\n");
    }
}

// ============================================================
// POINTERS AND ARRAYS
// ============================================================

void demonstrate_pointer_arithmetic() {
    printf("\n=== Pointer Arithmetic ===\n");
    
    int arr[] = {10, 20, 30, 40, 50};
    int *ptr = arr;  // Points to first element
    
    printf("Array elements using pointer arithmetic:\n");
    for (int i = 0; i < 5; i++) {
        printf("  arr[%d] = %d (address: %p)\n", i, *(ptr + i), (void*)(ptr + i));
    }
    
    // Alternative traversal
    printf("\nUsing pointer increment:\n");
    ptr = arr;
    for (int i = 0; i < 5; i++) {
        printf("  *ptr = %d\n", *ptr);
        ptr++;
    }
}

// ============================================================
// DYNAMIC MEMORY ALLOCATION
// ============================================================

typedef struct {
    int id;
    char name[50];
    double balance;
} Account;

void demonstrate_dynamic_memory() {
    printf("\n=== Dynamic Memory Allocation ===\n");
    
    // Allocate single integer
    int *num_ptr = (int*)malloc(sizeof(int));
    if (num_ptr == NULL) {
        printf("❌ Memory allocation failed\n");
        return;
    }
    
    *num_ptr = 42;
    printf("Dynamically allocated int: %d\n", *num_ptr);
    free(num_ptr);
    num_ptr = NULL;  // Good practice
    
    // Allocate array
    int *array = (int*)malloc(5 * sizeof(int));
    if (array != NULL) {
        for (int i = 0; i < 5; i++) {
            array[i] = i * 10;
        }
        
        printf("Dynamically allocated array: ");
        for (int i = 0; i < 5; i++) {
            printf("%d ", array[i]);
        }
        printf("\n");
        
        free(array);
    }
    
    // Allocate struct
    Account *acc = (Account*)malloc(sizeof(Account));
    if (acc != NULL) {
        acc->id = 12345;
        strcpy(acc->name, "Alice Johnson");
        acc->balance = 5000.50;
        
        printf("\nAccount: ID=%d, Name=%s, Balance=$%.2f\n",
               acc->id, acc->name, acc->balance);
        
        free(acc);
    }
}

// ============================================================
// POINTERS TO POINTERS
// ============================================================

void demonstrate_pointer_to_pointer() {
    printf("\n=== Pointers to Pointers ===\n");
    
    int value = 42;
    int *ptr = &value;
    int **ptr_ptr = &ptr;
    
    printf("Value: %d\n", value);
    printf("*ptr: %d\n", *ptr);
    printf("**ptr_ptr: %d\n", **ptr_ptr);
    
    // Modify through double pointer
    **ptr_ptr = 100;
    printf("After **ptr_ptr = 100, value is: %d\n", value);
}

// ============================================================
// FUNCTION POINTERS
// ============================================================

int add(int a, int b) {
    return a + b;
}

int subtract(int a, int b) {
    return a - b;
}

int multiply(int a, int b) {
    return a * b;
}

typedef int (*MathOperation)(int, int);

void demonstrate_function_pointers() {
    printf("\n=== Function Pointers ===\n");
    
    MathOperation operations[] = {add, subtract, multiply};
    const char *names[] = {"add", "subtract", "multiply"};
    
    int a = 10, b = 5;
    
    for (int i = 0; i < 3; i++) {
        int result = operations[i](a, b);
        printf("%s(%d, %d) = %d\n", names[i], a, b, result);
    }
}

// ============================================================
// PASS BY REFERENCE USING POINTERS
// ============================================================

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void demonstrate_pass_by_reference() {
    printf("\n=== Pass by Reference ===\n");
    
    int x = 10, y = 20;
    printf("Before swap: x=%d, y=%d\n", x, y);
    
    swap(&x, &y);
    printf("After swap: x=%d, y=%d\n", x, y);
}

// ============================================================
// LINKED LIST EXAMPLE
// ============================================================

typedef struct Node {
    int data;
    struct Node *next;
} Node;

Node* create_node(int data) {
    Node *new_node = (Node*)malloc(sizeof(Node));
    if (new_node == NULL) {
        printf("❌ Memory allocation failed\n");
        return NULL;
    }
    new_node->data = data;
    new_node->next = NULL;
    return new_node;
}

void print_list(Node *head) {
    Node *current = head;
    printf("List: ");
    while (current != NULL) {
        printf("%d -> ", current->data);
        current = current->next;
    }
    printf("NULL\n");
}

void free_list(Node *head) {
    Node *current = head;
    while (current != NULL) {
        Node *next = current->next;
        free(current);
        current = next;
    }
}

void demonstrate_linked_list() {
    printf("\n=== Linked List with Pointers ===\n");
    
    Node *head = create_node(10);
    head->next = create_node(20);
    head->next->next = create_node(30);
    head->next->next->next = create_node(40);
    
    print_list(head);
    
    free_list(head);
    printf("✓ List freed\n");
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    printf("=== Pointers in C ===\n\n");
    
    demonstrate_basic_pointers();
    demonstrate_pointer_arithmetic();
    demonstrate_dynamic_memory();
    demonstrate_pointer_to_pointer();
    demonstrate_function_pointers();
    demonstrate_pass_by_reference();
    demonstrate_linked_list();
    
    printf("\n✓ Program completed successfully\n");
    return 0;
}
