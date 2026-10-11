/*
 * Pointers in C++
 * Demonstrates raw pointers, smart pointers (unique_ptr, shared_ptr), and modern C++ memory management
 */

#include <iostream>
#include <memory>
#include <vector>
#include <string>

// ============================================================
// RAW POINTERS (Traditional C-style)
// ============================================================

void demonstrate_raw_pointers() {
    std::cout << "=== Raw Pointers ===\n";
    
    int value = 42;
    int* ptr = &value;
    
    std::cout << "Value: " << value << "\n";
    std::cout << "Pointer address: " << ptr << "\n";
    std::cout << "Dereferenced: " << *ptr << "\n";
    
    // Dynamic allocation
    int* dynamic_ptr = new int(100);
    std::cout << "Dynamic value: " << *dynamic_ptr << "\n";
    delete dynamic_ptr;  // Must manually free
    dynamic_ptr = nullptr;
}

// ============================================================
// UNIQUE_PTR (Exclusive ownership, no copying)
// ============================================================

class Resource {
public:
    Resource(const std::string& name) : name_(name) {
        std::cout << "✓ Resource '" << name_ << "' created\n";
    }
    
    ~Resource() {
        std::cout << "✓ Resource '" << name_ << "' destroyed\n";
    }
    
    void use() const {
        std::cout << "Using resource: " << name_ << "\n";
    }
    
private:
    std::string name_;
};

void demonstrate_unique_ptr() {
    std::cout << "\n=== Unique Pointer (unique_ptr) ===\n";
    
    // Automatic memory management
    std::unique_ptr<Resource> ptr1 = std::make_unique<Resource>("Resource1");
    ptr1->use();
    
    // Transfer ownership (move semantics)
    std::unique_ptr<Resource> ptr2 = std::move(ptr1);
    if (ptr1 == nullptr) {
        std::cout << "ptr1 is now nullptr (ownership transferred)\n";
    }
    ptr2->use();
    
    // Automatically deleted when ptr2 goes out of scope
}

// ============================================================
// SHARED_PTR (Shared ownership, reference counted)
// ============================================================

void demonstrate_shared_ptr() {
    std::cout << "\n=== Shared Pointer (shared_ptr) ===\n";
    
    std::shared_ptr<Resource> shared1 = std::make_shared<Resource>("Shared Resource");
    std::cout << "Reference count: " << shared1.use_count() << "\n";
    
    {
        std::shared_ptr<Resource> shared2 = shared1;  // Shared ownership
        std::cout << "Reference count after sharing: " << shared1.use_count() << "\n";
        shared2->use();
    }  // shared2 goes out of scope
    
    std::cout << "Reference count after shared2 destroyed: " << shared1.use_count() << "\n";
    // Resource automatically deleted when last shared_ptr is destroyed
}

// ============================================================
// WEAK_PTR (Non-owning observer)
// ============================================================

void demonstrate_weak_ptr() {
    std::cout << "\n=== Weak Pointer (weak_ptr) ===\n";
    
    std::shared_ptr<Resource> shared = std::make_shared<Resource>("Weak Resource");
    std::weak_ptr<Resource> weak = shared;
    
    std::cout << "Shared reference count: " << shared.use_count() << "\n";
    std::cout << "Weak pointer expired: " << (weak.expired() ? "Yes" : "No") << "\n";
    
    // Lock weak_ptr to access resource
    if (auto locked = weak.lock()) {
        locked->use();
        std::cout << "Reference count while locked: " << shared.use_count() << "\n";
    }
    
    shared.reset();  // Destroy resource
    std::cout << "Weak pointer expired: " << (weak.expired() ? "Yes" : "No") << "\n";
}

// ============================================================
// POINTER ARITHMETIC AND ARRAYS
// ============================================================

void demonstrate_pointer_arithmetic() {
    std::cout << "\n=== Pointer Arithmetic ===\n";
    
    int arr[] = {10, 20, 30, 40, 50};
    int* ptr = arr;
    
    std::cout << "Array elements:\n";
    for (int i = 0; i < 5; i++) {
        std::cout << "  arr[" << i << "] = " << *(ptr + i) << "\n";
    }
    
    // Modern C++ way (prefer iterators)
    std::vector<int> vec = {10, 20, 30, 40, 50};
    std::cout << "\nVector (modern C++):\n";
    for (const auto& val : vec) {
        std::cout << "  " << val << "\n";
    }
}

// ============================================================
// FUNCTION POINTERS AND LAMBDAS
// ============================================================

int add(int a, int b) { return a + b; }
int multiply(int a, int b) { return a * b; }

void demonstrate_function_pointers() {
    std::cout << "\n=== Function Pointers & Lambdas ===\n";
    
    // Traditional function pointer
    int (*func_ptr)(int, int) = add;
    std::cout << "Function pointer: add(5, 3) = " << func_ptr(5, 3) << "\n";
    
    func_ptr = multiply;
    std::cout << "Function pointer: multiply(5, 3) = " << func_ptr(5, 3) << "\n";
    
    // Modern C++ lambda (preferred)
    auto lambda = [](int a, int b) { return a - b; };
    std::cout << "Lambda: subtract(5, 3) = " << lambda(5, 3) << "\n";
}

// ============================================================
// LINKED LIST WITH SMART POINTERS
// ============================================================

struct Node {
    int data;
    std::unique_ptr<Node> next;
    
    Node(int val) : data(val), next(nullptr) {}
};

class LinkedList {
private:
    std::unique_ptr<Node> head;
    
public:
    void push_front(int value) {
        auto new_node = std::make_unique<Node>(value);
        new_node->next = std::move(head);
        head = std::move(new_node);
    }
    
    void print() const {
        std::cout << "List: ";
        Node* current = head.get();
        while (current != nullptr) {
            std::cout << current->data << " -> ";
            current = current->next.get();
        }
        std::cout << "nullptr\n";
    }
    
    ~LinkedList() {
        std::cout << "✓ Linked list destroyed (automatic cleanup)\n";
    }
};

void demonstrate_linked_list() {
    std::cout << "\n=== Linked List with Smart Pointers ===\n";
    
    LinkedList list;
    list.push_front(30);
    list.push_front(20);
    list.push_front(10);
    list.print();
    
    // Automatic cleanup when list goes out of scope
}

// ============================================================
// REFERENCES VS POINTERS
// ============================================================

void swap_ptr(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void swap_ref(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}

void demonstrate_references_vs_pointers() {
    std::cout << "\n=== References vs Pointers ===\n";
    
    int x = 10, y = 20;
    
    std::cout << "Before: x=" << x << ", y=" << y << "\n";
    swap_ptr(&x, &y);
    std::cout << "After swap_ptr: x=" << x << ", y=" << y << "\n";
    
    swap_ref(x, y);
    std::cout << "After swap_ref: x=" << x << ", y=" << y << "\n";
    
    std::cout << "\nReferences are cleaner and safer in C++!\n";
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    std::cout << "=== Pointers in C++ ===\n\n";
    
    demonstrate_raw_pointers();
    demonstrate_unique_ptr();
    demonstrate_shared_ptr();
    demonstrate_weak_ptr();
    demonstrate_pointer_arithmetic();
    demonstrate_function_pointers();
    demonstrate_linked_list();
    demonstrate_references_vs_pointers();
    
    std::cout << "\n💡 Modern C++ Best Practice:\n";
    std::cout << "   - Use unique_ptr for exclusive ownership\n";
    std::cout << "   - Use shared_ptr for shared ownership\n";
    std::cout << "   - Use weak_ptr to break circular references\n";
    std::cout << "   - Prefer references over raw pointers\n";
    std::cout << "   - Avoid manual new/delete\n";
    
    std::cout << "\n✓ Program completed successfully\n";
    return 0;
}
