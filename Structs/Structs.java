/*
 * Structures in Java
 * Java uses classes for everything, but Records (Java 16+) provide struct-like behavior
 */

import java.util.*;

// ============================================================
// TRADITIONAL POJO (Plain Old Java Object) - Pre-Java 16
// ============================================================

class Point {
    private int x;
    private int y;
    
    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public int getX() { return x; }
    public int getY() { return y; }
    public void setX(int x) { this.x = x; }
    public void setY(int y) { this.y = y; }
    
    @Override
    public String toString() {
        return "Point(" + x + ", " + y + ")";
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Point)) return false;
        Point point = (Point) o;
        return x == point.x && y == point.y;
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(x, y);
    }
}

// ============================================================
// RECORD (Java 16+) - Concise immutable data carrier
// ============================================================

record Person(String name, int age, Address address) {
    // Compact constructor for validation
    public Person {
        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative");
        }
    }
    
    // Custom methods can be added
    public boolean isAdult() {
        return age >= 18;
    }
}

record Address(String street, String city, String zipCode) {}

record Account(int id, String name, double balance) {
    // Derived methods
    public void printInfo() {
        System.out.printf("  ID: %d, Name: %s, Balance: $%.2f%n", id, name, balance);
    }
}

// ============================================================
// NESTED POJO
// ============================================================

class Rectangle {
    private double width;
    private double height;
    
    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }
    
    public double area() {
        return width * height;
    }
    
    public double perimeter() {
        return 2 * (width + height);
    }
    
    @Override
    public String toString() {
        return String.format("Rectangle(%.1fx%.1f)", width, height);
    }
}

// ============================================================
// DEMONSTRATION CLASS
// ============================================================

public class Structs {
    
    static void demonstrateBasicPOJO() {
        System.out.println("=== Basic POJO (Plain Old Java Object) ===");
        
        Point p1 = new Point(10, 20);
        System.out.println("Point: " + p1);
        
        p1.setX(15);
        System.out.println("After setX(15): " + p1);
    }
    
    static void demonstrateRecords() {
        System.out.println("\n=== Records (Java 16+) ===");
        
        Address addr = new Address("123 Main St", "Springfield", "12345");
        Person person = new Person("Alice Johnson", 30, addr);
        
        System.out.println("Name: " + person.name());
        System.out.println("Age: " + person.age());
        System.out.println("Address: " + person.address().street() + ", " +
                          person.address().city() + " " + person.address().zipCode());
        System.out.println("Is adult: " + person.isAdult());
        
        // Records are immutable
        // person.name = "Bob";  // ✗ Error: cannot assign to final field
    }
    
    static void demonstrateNestedStructs() {
        System.out.println("\n=== Nested Structures ===");
        
        Person person = new Person(
            "Bob Smith",
            35,
            new Address("456 Elm St", "Portland", "97201")
        );
        
        System.out.println("Person: " + person);
    }
    
    static void demonstrateArrayOfStructs() {
        System.out.println("\n=== Array of Structures ===");
        
        List<Account> accounts = List.of(
            new Account(1001, "Alice", 5000.50),
            new Account(1002, "Bob", 3200.75),
            new Account(1003, "Charlie", 7500.00)
        );
        
        System.out.println("Bank Accounts:");
        accounts.forEach(Account::printInfo);
    }
    
    static void demonstrateWithMethods() {
        System.out.println("\n=== Struct with Methods ===");
        
        Rectangle rect = new Rectangle(10, 5);
        System.out.println(rect);
        System.out.println("Area: " + rect.area());
        System.out.println("Perimeter: " + rect.perimeter());
    }
    
    static void demonstrateRecordPatternMatching() {
        System.out.println("\n=== Record Pattern Matching (Java 19+) ===");
        
        Person person = new Person("Charlie", 25, new Address("789 Oak St", "Boston", "02101"));
        
        // Pattern matching with records
        if (person instanceof Person(String name, int age, Address addr)) {
            System.out.println("Destructured: " + name + ", age " + age);
        }
    }
    
    static void demonstrateComparison() {
        System.out.println("\n=== Comparing Structures ===");
        
        Point p1 = new Point(10, 20);
        Point p2 = new Point(10, 20);
        Point p3 = new Point(15, 25);
        
        System.out.println("p1.equals(p2): " + p1.equals(p2));
        System.out.println("p1.equals(p3): " + p1.equals(p3));
        
        // Records automatically implement equals and hashCode
        Person person1 = new Person("Alice", 30, new Address("123 Main", "NYC", "10001"));
        Person person2 = new Person("Alice", 30, new Address("123 Main", "NYC", "10001"));
        System.out.println("person1.equals(person2): " + person1.equals(person2));
    }
    
    static void demonstrateRecordVsPOJO() {
        System.out.println("\n=== Record vs POJO ===");
        
        System.out.println("POJO (Point):");
        System.out.println("  - Mutable (has setters)");
        System.out.println("  - Verbose (manual equals, hashCode, toString)");
        System.out.println("  - Pre-Java 16 compatible");
        
        System.out.println("\nRecord (Person):");
        System.out.println("  - Immutable (no setters)");
        System.out.println("  - Concise (auto-generated methods)");
        System.out.println("  - Java 16+ required");
    }
    
    public static void main(String[] args) {
        System.out.println("=== Structures in Java ===\n");
        
        demonstrateBasicPOJO();
        demonstrateRecords();
        demonstrateNestedStructs();
        demonstrateArrayOfStructs();
        demonstrateWithMethods();
        demonstrateRecordPatternMatching();
        demonstrateComparison();
        demonstrateRecordVsPOJO();
        
        System.out.println("\n💡 Java Struct Alternatives:");
        System.out.println("   ✓ Use Records (Java 16+) for immutable data");
        System.out.println("   ✓ Use POJOs for mutable data");
        System.out.println("   ✓ Records reduce boilerplate significantly");
        System.out.println("   ✗ No direct struct keyword in Java");
        
        System.out.println("\n✓ Program completed successfully");
    }
}
