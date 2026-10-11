/*
 * Tuples in Java
 * Java doesn't have native tuples, but we can use Records (Java 16+) or custom classes
 */

import java.util.*;
import java.util.function.*;

// ============================================================
// GENERIC PAIR CLASS
// ============================================================

class Pair<T, U> {
    private final T first;
    private final U second;
    
    public Pair(T first, U second) {
        this.first = first;
        this.second = second;
    }
    
    public T getFirst() { return first; }
    public U getSecond() { return second; }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Pair)) return false;
        Pair<?, ?> pair = (Pair<?, ?>) o;
        return Objects.equals(first, pair.first) && 
               Objects.equals(second, pair.second);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(first, second);
    }
    
    @Override
    public String toString() {
        return "(" + first + ", " + second + ")";
    }
}

// ============================================================
// GENERIC TRIPLE CLASS
// ============================================================

class Triple<T, U, V> {
    private final T first;
    private final U second;
    private final V third;
    
    public Triple(T first, U second, V third) {
        this.first = first;
        this.second = second;
        this.third = third;
    }
    
    public T getFirst() { return first; }
    public U getSecond() { return second; }
    public V getThird() { return third; }
    
    @Override
    public String toString() {
        return "(" + first + ", " + second + ", " + third + ")";
    }
}

// ============================================================
// RECORDS (Java 16+) - Best practice for tuples
// ============================================================

record Point(int x, int y) {
    // Compact, immutable, with auto-generated equals, hashCode, toString
}

record Person(String name, int age, boolean isActive) {}

record DatabaseRow(int id, String email, String status, double balance) {}

// ============================================================
// DEMONSTRATION CLASS
// ============================================================

public class Tuples {
    
    // ============================================================
    // BASIC PAIR USAGE
    // ============================================================
    
    static void demonstrateBasicPair() {
        System.out.println("=== Basic Pair ===");
        
        Pair<String, Integer> person = new Pair<>("Alice", 30);
        System.out.println("Name: " + person.getFirst());
        System.out.println("Age: " + person.getSecond());
        System.out.println("Pair: " + person);
    }
    
    // ============================================================
    // RETURNING MULTIPLE VALUES
    // ============================================================
    
    static Triple<Integer, Integer, Integer> getRgbColor() {
        return new Triple<>(255, 128, 0);  // Orange color
    }
    
    static Pair<Boolean, String> divideWithError(int a, int b) {
        if (b == 0) {
            return new Pair<>(false, "Division by zero");
        }
        return new Pair<>(true, String.valueOf(a / b));
    }
    
    static void demonstrateReturnValues() {
        System.out.println("\n=== Returning Multiple Values ===");
        
        var rgb = getRgbColor();
        System.out.println("RGB: (" + rgb.getFirst() + ", " + 
                          rgb.getSecond() + ", " + rgb.getThird() + ")");
        
        var result1 = divideWithError(10, 2);
        if (result1.getFirst()) {
            System.out.println("Division result: " + result1.getSecond());
        }
        
        var result2 = divideWithError(10, 0);
        if (!result2.getFirst()) {
            System.out.println("Error: " + result2.getSecond());
        }
    }
    
    // ============================================================
    // RECORDS AS TUPLES
    // ============================================================
    
    static void demonstrateRecords() {
        System.out.println("\n=== Records as Tuples ===");
        
        Point p1 = new Point(10, 20);
        System.out.println("Point: " + p1);
        System.out.println("X: " + p1.x() + ", Y: " + p1.y());
        
        Person person = new Person("Bob", 35, true);
        System.out.println("Person: " + person);
        
        // Records are immutable
        // person.name = "Charlie";  // ✗ Error: cannot assign value
    }
    
    // ============================================================
    // RECORDS WITH PATTERN MATCHING (Java 16+)
    // ============================================================
    
    static void processShape(Object shape) {
        if (shape instanceof Point p) {
            System.out.println("Processing point at (" + p.x() + ", " + p.y() + ")");
        }
    }
    
    static void demonstratePatternMatching() {
        System.out.println("\n=== Pattern Matching with Records ===");
        
        Point p = new Point(5, 10);
        processShape(p);
    }
    
    // ============================================================
    // TUPLE AS MAP KEY
    // ============================================================
    
    static void demonstrateTupleAsKey() {
        System.out.println("\n=== Tuple as Map Key ===");
        
        Map<Point, String> treasureMap = new HashMap<>();
        treasureMap.put(new Point(10, 20), "Gold");
        treasureMap.put(new Point(5, 15), "Silver");
        
        Point location = new Point(10, 20);
        String treasure = treasureMap.get(location);
        System.out.println("Treasure at (10, 20): " + treasure);
    }
    
    // ============================================================
    // LIST OF TUPLES
    // ============================================================
    
    static void demonstrateListOfTuples() {
        System.out.println("\n=== List of Tuples ===");
        
        List<Pair<String, Integer>> students = List.of(
            new Pair<>("Alice", 95),
            new Pair<>("Bob", 87),
            new Pair<>("Charlie", 92)
        );
        
        System.out.println("Students:");
        for (var student : students) {
            System.out.println("  " + student.getFirst() + ": " + 
                             student.getSecond() + " points");
        }
        
        // Sort by score
        var sorted = students.stream()
            .sorted(Comparator.comparing(Pair::getSecond).reversed())
            .toList();
        
        System.out.println("\nSorted by score:");
        for (var student : sorted) {
            System.out.println("  " + student.getFirst() + ": " + 
                             student.getSecond() + " points");
        }
    }
    
    // ============================================================
    // SWAP FUNCTION
    // ============================================================
    
    static <T, U> Pair<U, T> swap(Pair<T, U> pair) {
        return new Pair<>(pair.getSecond(), pair.getFirst());
    }
    
    static void demonstrateSwap() {
        System.out.println("\n=== Swap Function ===");
        
        Pair<String, Integer> original = new Pair<>("Alice", 30);
        Pair<Integer, String> swapped = swap(original);
        
        System.out.println("Original: " + original);
        System.out.println("Swapped: " + swapped);
    }
    
    // ============================================================
    // PRACTICAL EXAMPLE: DATABASE ROW
    // ============================================================
    
    static DatabaseRow fetchUser(int id) {
        return new DatabaseRow(id, "user@example.com", "Active", 1250.50);
    }
    
    static void demonstrateDatabaseRow() {
        System.out.println("\n=== Practical Example: Database Row ===");
        
        DatabaseRow row = fetchUser(42);
        System.out.println("User Record:");
        System.out.println("  ID: " + row.id());
        System.out.println("  Email: " + row.email());
        System.out.println("  Status: " + row.status());
        System.out.println("  Balance: $" + row.balance());
    }
    
    // ============================================================
    // TUPLE WITH FUNCTION
    // ============================================================
    
    static void demonstrateTupleWithFunction() {
        System.out.println("\n=== Tuple with Function ===");
        
        List<Pair<String, Function<Integer, Integer>>> operations = List.of(
            new Pair<>("Double", x -> x * 2),
            new Pair<>("Square", x -> x * x),
            new Pair<>("Add 10", x -> x + 10)
        );
        
        int input = 5;
        System.out.println("Input: " + input);
        
        for (var op : operations) {
            int result = op.getSecond().apply(input);
            System.out.println("  " + op.getFirst() + ": " + result);
        }
    }
    
    // ============================================================
    // COMPARING TUPLES
    // ============================================================
    
    static void demonstrateComparison() {
        System.out.println("\n=== Comparing Tuples ===");
        
        Point p1 = new Point(10, 20);
        Point p2 = new Point(10, 20);
        Point p3 = new Point(15, 25);
        
        System.out.println("p1.equals(p2): " + p1.equals(p2));
        System.out.println("p1.equals(p3): " + p1.equals(p3));
        System.out.println("p1.hashCode() == p2.hashCode(): " + 
                          (p1.hashCode() == p2.hashCode()));
    }
    
    // ============================================================
    // MAIN - DEMONSTRATION
    // ============================================================
    
    public static void main(String[] args) {
        System.out.println("=== Tuples in Java ===\n");
        
        demonstrateBasicPair();
        demonstrateReturnValues();
        demonstrateRecords();
        demonstratePatternMatching();
        demonstrateTupleAsKey();
        demonstrateListOfTuples();
        demonstrateSwap();
        demonstrateDatabaseRow();
        demonstrateTupleWithFunction();
        demonstrateComparison();
        
        System.out.println("\n💡 Java Tuple Best Practices:");
        System.out.println("   ✓ Use Records (Java 16+) for immutable tuples");
        System.out.println("   ✓ Create generic Pair/Triple classes for reuse");
        System.out.println("   ✓ Consider third-party libraries (Apache Commons, Vavr)");
        System.out.println("   ✗ Don't overuse tuples (use domain objects for clarity)");
        System.out.println("   ✗ Avoid tuples with more than 3-4 elements");
        
        System.out.println("\n✓ Program completed successfully");
    }
}
