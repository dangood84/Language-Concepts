# Classes & Object-Oriented Programming (OOP)

This folder contains practical examples of OOP concepts across multiple programming languages.

## 🎯 Core OOP Concepts Demonstrated

1. **Encapsulation** - Data hiding and access control
2. **Inheritance** - Parent-child class relationships
3. **Polymorphism** - Method overriding and dynamic behavior
4. **Abstraction** - Abstract classes and interfaces

## 📚 Practical Example: Bank Account System

All examples implement a realistic bank account system with:
- Base `Account` class
- `SavingsAccount` subclass (with interest calculation)
- `CheckingAccount` subclass (with overdraft protection)
- Encapsulation of balance and transaction logic
- Polymorphic behavior for different account types

## 🗂️ Language Support

| Language   | Native OOP | File                  | Notes                                    |
|------------|------------|-----------------------|------------------------------------------|
| C          | ❌         | `bank_account.c`      | Struct-based OOP pattern (function pointers) |
| C++        | ✅         | `BankAccount.cpp`     | Full OOP with classes, inheritance, virtual methods |
| Java       | ✅         | `BankAccount.java`    | Pure OOP, interfaces, abstract classes |
| JavaScript | ✅         | `BankAccount.js`      | ES6 classes, prototypal inheritance |
| TypeScript | ✅         | `BankAccount.ts`      | Classes with type safety, interfaces |
| Fortran    | ⚠️         | `bank_account.f90`    | Derived types with type-bound procedures |
| Pascal     | ✅         | `BankAccount.pas`     | Object Pascal with classes |
| Bash       | ❌         | `bank_account.sh`     | Function-based organization (not true OOP) |
| Prolog     | ❌         | `bank_account.pl`     | Fact-based representation (logic paradigm) |

## 🚀 Quick Start

### C++
```bash
g++ -std=c++17 BankAccount.cpp -o bank && ./bank
```

### Java
```bash
javac BankAccount.java && java BankAccount
```

### JavaScript/TypeScript
```bash
node BankAccount.js
ts-node BankAccount.ts
```

### Fortran
```bash
gfortran -std=f2008 bank_account.f90 -o bank && ./bank
```

### Pascal
```bash
fpc BankAccount.pas && ./BankAccount
```

## 🎓 Learning Path

1. **Beginners**: Start with JavaScript or Python (not shown) for simple syntax
2. **Intermediate**: Move to Java or C++ for static typing and explicit OOP
3. **Advanced**: Explore Fortran or C for alternative OOP patterns
4. **Paradigm Shift**: See Prolog for logic-based alternatives to OOP

## 📖 Key Takeaways

- OOP promotes **code reusability** through inheritance
- **Encapsulation** protects data integrity
- **Polymorphism** enables flexible, extensible designs
- Not all languages require classes for good software design
