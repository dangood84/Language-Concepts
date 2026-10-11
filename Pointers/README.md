# Pointers

This folder contains practical examples of pointer manipulation across languages that support them.

## 🎯 What are Pointers?

Pointers are variables that store memory addresses of other variables. They enable:
- Direct memory manipulation
- Dynamic memory allocation
- Efficient pass-by-reference
- Complex data structures (linked lists, trees, graphs)
- Function callbacks

## 📚 Practical Examples

All examples demonstrate:
- Pointer declaration and initialization
- Dereferencing (* operator)
- Address-of operator (&)
- Pointer arithmetic
- Dynamic memory allocation
- Pointers to functions
- Common pitfalls (null pointers, dangling pointers, memory leaks)

## 🗂️ Language Support

| Language   | Native Support | File                  | Notes                                    |
|------------|----------------|-----------------------|------------------------------------------|
| C          | ✅             | `pointers.c`          | Raw pointers with malloc/free            |
| C++        | ✅             | `pointers.cpp`        | Raw pointers + smart pointers (unique_ptr, shared_ptr) |
| Java       | ❌             | N/A                   | References only (not true pointers)      |
| JavaScript | ❌             | N/A                   | References only                          |
| TypeScript | ❌             | N/A                   | References only                          |
| Fortran    | ✅             | `pointers.f90`        | Pointers to targets (Fortran 90+)        |
| Pascal     | ✅             | `pointers.pas`        | Typed pointers with New/Dispose          |
| Bash       | ❌             | N/A                   | No pointer support                       |
| Prolog     | ❌             | N/A                   | Unification, not pointers                |

## 🚀 Quick Start

### C
```bash
gcc pointers.c -o pointers && ./pointers
```

### C++
```bash
g++ -std=c++17 pointers.cpp -o pointers && ./pointers
```

### Fortran
```bash
gfortran -std=f2008 pointers.f90 -o pointers && ./pointers
```

### Pascal
```bash
fpc pointers.pas && ./pointers
```

## ⚠️ Common Pitfalls

1. **Null/Dangling Pointers**: Dereferencing invalid memory
2. **Memory Leaks**: Forgetting to free allocated memory
3. **Buffer Overflows**: Writing beyond allocated bounds
4. **Wild Pointers**: Using uninitialized pointers
5. **Double Free**: Freeing same memory twice

## 💡 Best Practices

- ✅ Always initialize pointers (to NULL if not yet assigned)
- ✅ Check for NULL before dereferencing
- ✅ Free dynamically allocated memory
- ✅ Set pointers to NULL after freeing
- ✅ Use smart pointers in C++ (unique_ptr, shared_ptr)
- ❌ Avoid pointer arithmetic unless necessary
- ❌ Don't return pointers to local variables

## 🎓 When to Use Pointers

- ✅ Dynamic data structures (linked lists, trees, graphs)
- ✅ Large data structures (avoid copying)
- ✅ Resource management (files, network connections)
- ✅ Low-level system programming
- ❌ When references are sufficient (Java, JavaScript, modern C++)
