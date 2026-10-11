#!/bin/bash

# Structures in Bash
# Bash doesn't have native structs, but we can simulate them with associative arrays

# ============================================================
# BASIC STRUCT SIMULATION (Associative Arrays)
# ============================================================

demonstrate_basic_struct() {
    echo "=== Basic Struct Simulation ==="
    
    # Declare associative array
    declare -A point
    point[x]=10
    point[y]=20
    
    echo "Point: (${point[x]}, ${point[y]})"
    
    # Modify values
    point[x]=15
    echo "After modification: (${point[x]}, ${point[y]})"
}

# ============================================================
# MULTIPLE STRUCTS (Naming convention)
# ============================================================

demonstrate_multiple_structs() {
    echo ""
    echo "=== Multiple Structs ==="
    
    # Person 1
    declare -A person1
    person1[name]="Alice Johnson"
    person1[age]=30
    person1[city]="Springfield"
    
    # Person 2
    declare -A person2
    person2[name]="Bob Smith"
    person2[age]=35
    person2[city]="Portland"
    
    echo "Person 1: ${person1[name]}, age ${person1[age]}, from ${person1[city]}"
    echo "Person 2: ${person2[name]}, age ${person2[age]}, from ${person2[city]}"
}

# ============================================================
# NESTED STRUCTS (Flattened with prefixes)
# ============================================================

demonstrate_nested_structs() {
    echo ""
    echo "=== Nested Structs (Flattened) ==="
    
    declare -A person
    person[name]="Alice Johnson"
    person[age]=30
    person[address_street]="123 Main St"
    person[address_city]="Springfield"
    person[address_zip]="12345"
    
    echo "Name: ${person[name]}"
    echo "Age: ${person[age]}"
    echo "Address: ${person[address_street]}, ${person[address_city]} ${person[address_zip]}"
}

# ============================================================
# ARRAY OF STRUCTS (Using indexed arrays)
# ============================================================

demonstrate_array_of_structs() {
    echo ""
    echo "=== Array of Structs ==="
    
    # Arrays for each field
    declare -a ids=(1001 1002 1003)
    declare -a names=("Alice" "Bob" "Charlie")
    declare -a balances=(5000.50 3200.75 7500.00)
    
    echo "Bank Accounts:"
    for i in "${!ids[@]}"; do
        echo "  ID: ${ids[$i]}, Name: ${names[$i]}, Balance: \$${balances[$i]}"
    done
}

# ============================================================
# STRUCT WITH FUNCTIONS
# ============================================================

# Create a rectangle "struct"
create_rectangle() {
    local width=$1
    local height=$2
    
    declare -gA rect
    rect[width]=$width
    rect[height]=$height
}

rectangle_area() {
    echo "$((rect[width] * rect[height]))"
}

rectangle_perimeter() {
    echo "$((2 * (rect[width] + rect[height])))"
}

demonstrate_struct_with_functions() {
    echo ""
    echo "=== Struct with Functions ==="
    
    create_rectangle 10 5
    echo "Rectangle: ${rect[width]}x${rect[height]}"
    echo "Area: $(rectangle_area)"
    echo "Perimeter: $(rectangle_perimeter)"
}

# ============================================================
# SERIALIZATION (Convert to string)
# ============================================================

serialize_struct() {
    local -n struct_ref=$1
    local result=""
    
    for key in "${!struct_ref[@]}"; do
        result+="$key=${struct_ref[$key]};"
    done
    
    echo "$result"
}

deserialize_struct() {
    local data=$1
    declare -gA loaded_struct
    
    IFS=';' read -ra pairs <<< "$data"
    for pair in "${pairs[@]}"; do
        if [[ -n "$pair" ]]; then
            IFS='=' read -r key value <<< "$pair"
            loaded_struct[$key]=$value
        fi
    done
}

demonstrate_serialization() {
    echo ""
    echo "=== Serialization ==="
    
    declare -A point
    point[x]=10
    point[y]=20
    point[z]=30
    
    serialized=$(serialize_struct point)
    echo "Serialized: $serialized"
    
    deserialize_struct "$serialized"
    echo "Deserialized: x=${loaded_struct[x]}, y=${loaded_struct[y]}, z=${loaded_struct[z]}"
}

# ============================================================
# COPYING STRUCTS
# ============================================================

copy_struct() {
    local -n source=$1
    local -n dest=$2
    
    for key in "${!source[@]}"; do
        dest[$key]=${source[$key]}
    done
}

demonstrate_copying() {
    echo ""
    echo "=== Copying Structs ==="
    
    declare -A original
    original[name]="Alice"
    original[age]=30
    
    declare -A copy
    copy_struct original copy
    
    echo "Original: ${original[name]}, age ${original[age]}"
    echo "Copy: ${copy[name]}, age ${copy[age]}"
    
    # Modify copy
    copy[age]=31
    echo "After modifying copy:"
    echo "  Original age: ${original[age]}"
    echo "  Copy age: ${copy[age]}"
}

# ============================================================
# COMPARISON
# ============================================================

structs_equal() {
    local -n struct1=$1
    local -n struct2=$2
    
    # Check if they have the same keys
    if [[ "${!struct1[*]}" != "${!struct2[*]}" ]]; then
        return 1
    fi
    
    # Check if all values match
    for key in "${!struct1[@]}"; do
        if [[ "${struct1[$key]}" != "${struct2[$key]}" ]]; then
            return 1
        fi
    done
    
    return 0
}

demonstrate_comparison() {
    echo ""
    echo "=== Comparing Structs ==="
    
    declare -A p1 p2 p3
    p1[x]=10
    p1[y]=20
    
    p2[x]=10
    p2[y]=20
    
    p3[x]=15
    p3[y]=25
    
    if structs_equal p1 p2; then
        echo "p1 equals p2: true"
    else
        echo "p1 equals p2: false"
    fi
    
    if structs_equal p1 p3; then
        echo "p1 equals p3: true"
    else
        echo "p1 equals p3: false"
    fi
}

# ============================================================
# PRACTICAL EXAMPLE: Configuration
# ============================================================

demonstrate_config() {
    echo ""
    echo "=== Practical Example: Configuration ==="
    
    declare -A config
    config[api_url]="https://api.example.com"
    config[timeout]=5000
    config[retries]=3
    config[debug]="false"
    
    echo "Configuration:"
    for key in "${!config[@]}"; do
        echo "  $key: ${config[$key]}"
    done
}

# ============================================================
# MAIN - DEMONSTRATION
# ============================================================

main() {
    echo "=== Structures in Bash ==="
    echo ""
    
    demonstrate_basic_struct
    demonstrate_multiple_structs
    demonstrate_nested_structs
    demonstrate_array_of_structs
    demonstrate_struct_with_functions
    demonstrate_serialization
    demonstrate_copying
    demonstrate_comparison
    demonstrate_config
    
    echo ""
    echo "💡 Bash Struct Simulation:"
    echo "   ✓ Use associative arrays (Bash 4+)"
    echo "   ✓ Use naming conventions for namespacing"
    echo "   ✓ Flatten nested structures with prefixes"
    echo "   ✗ No native struct support"
    echo "   ✗ Limited type checking"
    
    echo ""
    echo "✓ Program completed successfully"
}

main
