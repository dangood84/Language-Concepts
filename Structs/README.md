# Structs (Structures)

This folder contains practical examples of structures/records across multiple programming languages.

## 🎯 What are Structs?

Structures (structs) are composite data types that group related variables under a single name. They enable:
- Data organization and encapsulation
- Custom data types
- Representing real-world entities
- Passing multiple related values together

## 📚 Practical Examples

All examples demonstrate:
- Struct declaration and initialization
- Accessing struct members (dot notation)
- Nested structs
- Arrays of structs
- Passing structs to functions
- Memory layout considerations

## 🗂️ Language Support

| Language   | Native Support | File                  | Notes                                    |
|------------|----------------|-----------------------|------------------------------------------|
| C          | ✅             | `structs.c`           | Pure structs with typedef                |
| C++        | ✅             | `structs.cpp`         | Structs with methods (like classes)      |
| Java       | ⚠️             | `Structs.java`        | Classes/POJOs, Records (Java 16+)        |
| JavaScript | ⚠️             | `structs.js`          | Objects serve as structs                 |
| TypeScript | ✅             | `structs.ts`          | Interfaces and type literals             |
| Fortran    | ✅             | `structs.f90`         | Derived types with type-bound procedures |
| Pascal     | ✅             | `structs.pas`         | Record types (packed records available)  |
| Bash       | ⚠️             | `structs.sh`          | Associative arrays simulate structs      |
| Prolog     | ✅             | `structs.pl`          | Compound terms/functors                  |

## 🚀 Quick Start

### C
```bash
gcc structs.c -o structs && ./structs
```

### C++
```bash
g++ -std=c++17 structs.cpp -o structs && ./structs
```

### TypeScript
```bash
ts-node structs.ts
```

### Fortran
```bash
gfortran -std=f2008 structs.f90 -o structs && ./structs
```

### Pascal
```bash
fpc structs.pas && ./structs
```

## 💡 Struct vs Class

| Feature       | Struct (C)         | Struct (C++)      | Class              |
|---------------|-------------------|-------------------|-------------------|
| Default access | N/A               | Public            | Private           |
| Methods        | No                | Yes               | Yes               |
| Inheritance    | No                | Yes               | Yes               |
| Use case       | Plain data        | Value types       | Complex behavior  |

## 🎓 Common Use Cases

- ✅ Representing database records (User, Product, Order)
- ✅ Coordinate systems (Point, Vector, Rectangle)
- ✅ Configuration data
- ✅ API request/response payloads
- ✅ File format headers

## ⚡ Performance Notes

- Structs are typically allocated on the stack (fast)
- Pass large structs by pointer/reference to avoid copying
- Memory layout is sequential (good cache locality)
- Padding may be added for alignment (check sizeof)

## 🔍 Example: Person Struct

```c
struct Person {
    char name[50];
    int age;
    float height;
};

struct Person p = {"Alice", 30, 5.6};
printf("%s is %d years old\n", p.name, p.age);
```
