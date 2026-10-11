# Enumerations (Enums)

This folder contains practical examples of enumerations across multiple programming languages.

## 🎯 What are Enums?

Enumerations are user-defined data types consisting of a set of named constants (enumerators). They improve code readability, type safety, and maintainability by replacing "magic numbers" or strings with meaningful names.

## 📚 Practical Example: HTTP Status Codes & Days of Week

All examples demonstrate:
- HTTP status code enumerations (200 OK, 404 Not Found, etc.)
- Days of the week
- Enum-to-string conversions
- Enum comparisons and switch statements
- Bitwise flags (where applicable)

## 🗂️ Language Support

| Language   | Native Support | File                  | Notes                                    |
|------------|----------------|-----------------------|------------------------------------------|
| C          | ✅             | `enums.c`             | Simple integer-based enums               |
| C++        | ✅             | `enums.cpp`           | Enum classes (C++11) with type safety    |
| Java       | ✅             | `Enums.java`          | Full-featured enum classes with methods  |
| JavaScript | ⚠️             | `enums.js`            | Simulated with Object.freeze             |
| TypeScript | ✅             | `enums.ts`            | Numeric and string enums                 |
| Fortran    | ✅             | `enums.f90`           | Enumerators (Fortran 2003+)              |
| Pascal     | ✅             | `enums.pas`           | Enumerated types with sets               |
| Bash       | ⚠️             | `enums.sh`            | Readonly variables & associative arrays  |
| Prolog     | ⚠️             | `enums.pl`            | Atoms and facts                          |

## 🚀 Quick Start

### C/C++
```bash
gcc enums.c -o enums && ./enums
g++ -std=c++11 enums.cpp -o enums && ./enums
```

### Java
```bash
javac Enums.java && java Enums
```

### JavaScript/TypeScript
```bash
node enums.js
ts-node enums.ts
```

### Fortran
```bash
gfortran -std=f2008 enums.f90 -o enums && ./enums
```

### Pascal
```bash
fpc enums.pas && ./enums
```

## 🎓 Key Concepts

1. **Type Safety**: Enums prevent invalid values at compile time
2. **Readability**: `HttpStatus.OK` is clearer than `200`
3. **Maintainability**: Change enum values in one place
4. **Pattern Matching**: Switch/case statements with enums

## 💡 When to Use Enums

- ✅ Fixed set of related constants (days, months, status codes)
- ✅ State machines (Pending, Running, Complete)
- ✅ Configuration options (Low, Medium, High)
- ✅ Error codes and status flags
- ❌ Dynamic or frequently changing value sets

## 🔍 Advanced Features by Language

- **Java**: Methods in enums, implements interfaces
- **TypeScript**: String enums, const enums, ambient enums
- **C++11+**: Enum classes with scoping and type safety
- **Fortran**: Enumerator with custom values
