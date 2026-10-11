# Language-Concepts: Comparative Programming Language Guide

A comprehensive educational repository demonstrating fundamental programming concepts across 9 different programming languages.

## 🎯 Project Overview

This repository provides side-by-side implementations of core programming concepts in multiple languages, making it easy to:
- Learn how the same concept works across different languages
- Compare syntax and idiomatic approaches
- Quickly reference implementation patterns
- Understand language-specific features and limitations

## 📚 Languages Covered

| Language   | Paradigm              | Type System    | Use Cases                          |
|------------|-----------------------|----------------|------------------------------------|
| C          | Procedural            | Static, Weak   | Systems programming, embedded      |
| C++        | Multi-paradigm        | Static, Strong | Performance-critical applications  |
| Java       | Object-oriented       | Static, Strong | Enterprise, Android                |
| JavaScript | Multi-paradigm        | Dynamic, Weak  | Web development, Node.js           |
| TypeScript | Multi-paradigm        | Static, Strong | Type-safe web development          |
| Fortran    | Procedural/Array      | Static, Strong | Scientific computing               |
| Pascal     | Procedural/OO         | Static, Strong | Education, Delphi                  |
| Bash       | Scripting             | Dynamic        | Shell scripting, automation        |
| Prolog     | Logic programming     | Dynamic        | AI, symbolic reasoning             |

## 📂 Concept Folders

### 1. [Classes-OOP/](Classes-OOP/)
**Object-Oriented Programming** - Classes, inheritance, polymorphism, encapsulation

**Example**: Bank Account System with Account, SavingsAccount, CheckingAccount

**Supported Languages**: All 9 languages (some simulate OOP)

### 2. [Enums/](Enums/)
**Enumerated Types** - Named constants, type-safe values, state machines

**Example**: HTTP Status Codes, Days of Week, Traffic Lights

**Supported Languages**: C, C++ (via enum class), Java, JavaScript (simulated), TypeScript, Fortran, Pascal, Bash (simulated), Prolog (atoms)

### 3. [Pointers/](Pointers/)
**Pointer Management** - Memory addresses, dynamic allocation, smart pointers

**Example**: Linked lists, dynamic arrays, memory management

**Supported Languages**: C, C++, Fortran, Pascal (others don't have direct pointer support)

### 4. [Structs/](Structs/)
**Structures/Records** - Composite data types, data organization

**Example**: Person with nested Address, Product catalog, Coordinate systems

**Supported Languages**: All 9 languages (C/C++ struct, Java classes/records, JS objects, TypeScript interfaces, Fortran derived types, Pascal records, Bash associative arrays, Prolog compound terms)

### 5. [Tuples/](Tuples/)
**Tuples** - Fixed-size heterogeneous collections, multiple return values

**Example**: Returning multiple values, coordinate pairs, database rows

**Supported Languages**: C++ (std::tuple), Java (Records, Pair classes), TypeScript, Prolog (compound terms)

## 🚀 Quick Start

### Prerequisites
Install the compilers/interpreters for languages you want to explore:

```bash
# C/C++
gcc --version
g++ --version

# Java
javac --version

# TypeScript/JavaScript
node --version
npm install -g typescript

# Fortran
gfortran --version

# Pascal
fpc -h

# Bash (usually pre-installed)
bash --version

# Prolog (SWI-Prolog recommended)
swipl --version
```

### Running Examples

Navigate to any concept folder and run the examples:

```bash
# C
cd Classes-OOP
gcc bank_account.c -o bank_account && ./bank_account

# C++
g++ -std=c++17 BankAccount.cpp -o BankAccount && ./BankAccount

# Java
javac BankAccount.java && java BankAccount

# TypeScript
ts-node BankAccount.ts

# JavaScript
node BankAccount.js

# Fortran
gfortran -std=f2008 bank_account.f90 -o bank_account && ./bank_account

# Pascal
fpc BankAccount.pas && ./BankAccount

# Bash
bash bank_account.sh

# Prolog
swipl -s bank_account.pl
```

## 📖 Learning Paths

### Path 1: From C to Modern C++
1. Start with [Structs/structs.c](Structs/structs.c) - Plain C structs
2. Move to [Structs/structs.cpp](Structs/structs.cpp) - C++ structs with methods
3. Explore [Classes-OOP/BankAccount.cpp](Classes-OOP/BankAccount.cpp) - Full OOP with classes
4. Study [Pointers/pointers.cpp](Pointers/pointers.cpp) - Smart pointers and RAII

### Path 2: Type-Safe Programming
1. [Enums/enums.c](Enums/enums.c) - Integer-based enums (C)
2. [Enums/Enums.java](Enums/Enums.java) - Type-safe enum classes (Java)
3. [Enums/enums.ts](Enums/enums.ts) - Enum types in TypeScript
4. Compare trade-offs between compile-time and runtime safety

### Path 3: Object-Oriented Design
1. [Classes-OOP/BankAccount.java](Classes-OOP/BankAccount.java) - Pure OOP (Java)
2. [Classes-OOP/BankAccount.ts](Classes-OOP/BankAccount.ts) - TypeScript with interfaces
3. [Classes-OOP/bank_account.c](Classes-OOP/bank_account.c) - OOP simulation in C
4. [Classes-OOP/bank_account.pl](Classes-OOP/bank_account.pl) - Logic-based approach

### Path 4: Functional & Logic Programming
1. [Tuples/tuples.cpp](Tuples/tuples.cpp) - Structured bindings in C++
2. [Tuples/Tuples.java](Tuples/Tuples.java) - Records and immutability
3. [Tuples/tuples.pl](Tuples/tuples.pl) - Pattern matching in Prolog
4. Explore declarative programming paradigms

## 💡 Best Practices by Concept

### Classes & OOP
- ✅ Use encapsulation to hide implementation details
- ✅ Favor composition over inheritance
- ✅ Follow SOLID principles
- ✅ Use interfaces/protocols for polymorphism

### Enums
- ✅ Use enums for fixed sets of related constants
- ✅ Prefer type-safe enums over integer constants
- ✅ Document enum values and their meanings
- ❌ Don't use enums for open-ended values

### Pointers
- ✅ Always initialize pointers
- ✅ Check for null/nullptr before dereferencing
- ✅ Use smart pointers in modern C++
- ✅ Free allocated memory (or use RAII)
- ❌ Avoid pointer arithmetic unless necessary

### Structs
- ✅ Use structs for simple data grouping
- ✅ Keep structs focused and cohesive
- ✅ Consider memory alignment/padding
- ❌ Don't add complex behavior to structs (use classes)

### Tuples
- ✅ Use tuples for returning multiple values
- ✅ Prefer destructuring for readability
- ✅ Limit to 3-4 elements max
- ❌ Don't use tuples when a named struct is clearer

## 📊 Language Feature Matrix

| Concept        | C  | C++ | Java | JS | TS | Fortran | Pascal | Bash | Prolog |
|----------------|----|----|------|----|----|---------|--------|------|--------|
| Native Classes | ❌ | ✅  | ✅   | ✅ | ✅ | ⚠️      | ✅     | ❌   | ❌     |
| Enums          | ⚠️ | ✅  | ✅   | ⚠️ | ✅ | ✅      | ✅     | ❌   | ⚠️     |
| Pointers       | ✅ | ✅  | ❌   | ❌ | ❌ | ✅      | ✅     | ❌   | ❌     |
| Structs        | ✅ | ✅  | ⚠️   | ⚠️ | ✅ | ✅      | ✅     | ⚠️   | ✅     |
| Tuples         | ❌ | ✅  | ⚠️   | ⚠️ | ✅ | ❌      | ❌     | ❌   | ✅     |

**Legend**: ✅ Native support | ⚠️ Partial/simulated | ❌ Not supported

## 🎓 Educational Use

This repository is designed for:
- **Students** learning multiple programming languages
- **Professionals** transitioning between languages
- **Educators** teaching comparative programming
- **Developers** looking for quick syntax references

## 🔍 Code Quality Standards

All examples follow these principles:
- ✅ Practical, real-world scenarios (not toy examples)
- ✅ Comprehensive comments explaining key concepts
- ✅ Idiomatic code for each language
- ✅ Working, tested examples
- ✅ Consistent formatting and structure

## 📝 Project Statistics

- **Languages**: 9
- **Concepts**: 5
- **Example Files**: 28+
- **Total Lines of Code**: 5000+

## 🤝 Contributing

Contributions are welcome! Please:
1. Follow existing code style and structure
2. Add comprehensive comments
3. Include practical examples
4. Test all code before submitting
5. Update README files accordingly

## 📄 License

This project is provided for educational purposes. Feel free to use, modify, and distribute.

## 🙏 Acknowledgments

Created to help programmers understand how fundamental concepts translate across different programming languages and paradigms.

---

**Happy Learning! 🚀**

_Last Updated: 2024_
