# Tuples

This folder contains practical examples of tuples across programming languages.

## 🎯 What are Tuples?

Tuples are immutable, ordered collections of heterogeneous elements. They enable:
- Returning multiple values from functions
- Grouping related data without defining a custom type
- Pattern matching and destructuring
- Fixed-size collections with type safety

## 📚 Practical Examples

All examples demonstrate:
- Tuple creation and initialization
- Accessing tuple elements (indexing or named fields)
- Tuple destructuring/unpacking
- Returning tuples from functions
- Comparing tuples
- Named tuples (where supported)

## 🗂️ Language Support

| Language   | Native Support | File                  | Notes                                    |
|------------|----------------|-----------------------|------------------------------------------|
| C          | ⚠️             | `tuples.c`            | Simulated with structs                   |
| C++        | ✅             | `tuples.cpp`          | std::tuple (C++11+), std::pair           |
| Java       | ⚠️             | `Tuples.java`         | Records (Java 16+), or custom classes    |
| JavaScript | ⚠️             | `tuples.js`           | Arrays with destructuring                |
| TypeScript | ✅             | `tuples.ts`           | Native tuple types with type safety      |
| Fortran    | ❌             | N/A                   | No native tuple support                  |
| Pascal     | ❌             | N/A                   | No native tuple support                  |
| Bash       | ❌             | N/A                   | Arrays (not true tuples)                 |
| Prolog     | ✅             | `tuples.pl`           | Compound terms (functors)                |

## 🚀 Quick Start

### C++
```bash
g++ -std=c++17 tuples.cpp -o tuples && ./tuples
```

### Java
```bash
javac Tuples.java && java Tuples
```

### TypeScript
```bash
ts-node tuples.ts
```

### Prolog
```bash
swipl -s tuples.pl
```

## 💡 Tuple vs Array vs Struct

| Feature       | Tuple              | Array             | Struct            |
|---------------|-------------------|-------------------|-------------------|
| Size          | Fixed             | Fixed/Dynamic     | Fixed             |
| Element types | Heterogeneous     | Homogeneous       | Heterogeneous     |
| Mutability    | Immutable*        | Mutable           | Mutable           |
| Access        | By index/name     | By index          | By name           |

*Immutability depends on language

## 🎓 Common Use Cases

- ✅ Returning multiple values from functions
  ```python
  def get_coordinates():
      return (x, y, z)
  ```
- ✅ Destructuring assignments
  ```typescript
  let [first, second] = [1, 2];
  ```
- ✅ Dictionary/Map keys (when immutable)
- ✅ Pattern matching in functional languages
- ✅ Temporary groupings without custom types

## 🔍 Example: Tuple Usage

### TypeScript
```typescript
let person: [string, number, boolean] = ["Alice", 30, true];
let [name, age, isActive] = person;
```

### C++
```cpp
std::tuple<std::string, int, bool> person{"Alice", 30, true};
auto [name, age, isActive] = person;
```

### Python (for reference)
```python
person = ("Alice", 30, True)
name, age, is_active = person
```

## ⚡ When to Use Tuples

- ✅ Quick, temporary data grouping
- ✅ Returning multiple values
- ✅ When you don't want to define a full struct/class
- ❌ When data needs a descriptive name (use struct instead)
- ❌ When mutability is required
- ❌ For complex data with behavior (use classes)

## 🌟 Advanced Features

- **Named Tuples** (Python, TypeScript): Tuple with named fields
- **Structured Bindings** (C++17): Auto destructure tuples
- **Records** (Java 16+): Immutable data carriers with tuple-like syntax
- **Pattern Matching**: Destructure and match tuple patterns
