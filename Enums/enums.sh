#!/bin/bash

# Enums in Bash
# Bash doesn't have native enums, but we can simulate them with readonly variables

# ============================================================
# BASIC ENUM SIMULATION (Readonly Variables)
# ============================================================

demonstrate_basic_enum() {
    echo "=== Basic Enum Simulation ==="
    
    # Declare constants
    readonly RED=0
    readonly GREEN=1
    readonly BLUE=2
    
    local color=$RED
    echo "Color RED: $color"
    
    color=$GREEN
    echo "Color GREEN: $color"
    
    color=$BLUE
    echo "Color BLUE: $color"
}

# ============================================================
# HTTP STATUS CODES
# ============================================================

# Define HTTP status "enum"
readonly HTTP_OK=200
readonly HTTP_CREATED=201
readonly HTTP_BAD_REQUEST=400
readonly HTTP_UNAUTHORIZED=401
readonly HTTP_NOT_FOUND=404
readonly HTTP_SERVER_ERROR=500

http_status_to_string() {
    local status=$1
    case $status in
        200) echo "200 OK" ;;
        201) echo "201 Created" ;;
        400) echo "400 Bad Request" ;;
        401) echo "401 Unauthorized" ;;
        404) echo "404 Not Found" ;;
        500) echo "500 Internal Server Error" ;;
        *) echo "Unknown Status" ;;
    esac
}

demonstrate_http_status() {
    echo ""
    echo "=== HTTP Status Codes ==="
    
    local status=$HTTP_OK
    echo "Status: $(http_status_to_string $status)"
    
    status=$HTTP_NOT_FOUND
    echo "Status: $(http_status_to_string $status)"
    
    status=$HTTP_SERVER_ERROR
    echo "Status: $(http_status_to_string $status)"
}

# ============================================================
# DAYS OF WEEK
# ============================================================

readonly MONDAY=0
readonly TUESDAY=1
readonly WEDNESDAY=2
readonly THURSDAY=3
readonly FRIDAY=4
readonly SATURDAY=5
readonly SUNDAY=6

day_to_string() {
    local day=$1
    case $day in
        0) echo "Monday" ;;
        1) echo "Tuesday" ;;
        2) echo "Wednesday" ;;
        3) echo "Thursday" ;;
        4) echo "Friday" ;;
        5) echo "Saturday" ;;
        6) echo "Sunday" ;;
        *) echo "Unknown" ;;
    esac
}

is_weekday() {
    local day=$1
    if [ $day -ge $MONDAY ] && [ $day -le $FRIDAY ]; then
        return 0  # true
    else
        return 1  # false
    fi
}

demonstrate_days_of_week() {
    echo ""
    echo "=== Days of Week ==="
    
    local today=$WEDNESDAY
    echo "Today: $(day_to_string $today)"
    
    if is_weekday $today; then
        echo "It's a weekday"
    else
        echo "It's a weekend"
    fi
    
    echo ""
    echo "All days:"
    for day in $MONDAY $TUESDAY $WEDNESDAY $THURSDAY $FRIDAY $SATURDAY $SUNDAY; do
        echo "  $(day_to_string $day)"
    done
}

# ============================================================
# PRIORITY LEVELS
# ============================================================

readonly PRIORITY_LOW=1
readonly PRIORITY_MEDIUM=5
readonly PRIORITY_HIGH=10
readonly PRIORITY_CRITICAL=100

demonstrate_priority() {
    echo ""
    echo "=== Priority Levels ==="
    
    local priority=$PRIORITY_LOW
    echo "LOW priority: $priority"
    
    priority=$PRIORITY_MEDIUM
    echo "MEDIUM priority: $priority"
    
    priority=$PRIORITY_HIGH
    echo "HIGH priority: $priority"
    
    priority=$PRIORITY_CRITICAL
    echo "CRITICAL priority: $priority"
    
    if [ $PRIORITY_HIGH -gt $PRIORITY_MEDIUM ]; then
        echo "HIGH priority is greater than MEDIUM"
    fi
}

# ============================================================
# BITWISE FLAGS (Using integers)
# ============================================================

readonly PERMISSION_NONE=0
readonly PERMISSION_READ=1
readonly PERMISSION_WRITE=2
readonly PERMISSION_EXECUTE=4

has_permission() {
    local permissions=$1
    local flag=$2
    local result=$((permissions & flag))
    [ $result -ne 0 ]
}

demonstrate_bitwise_flags() {
    echo ""
    echo "=== Bitwise Flags ==="
    
    # Combine flags
    local permissions=$((PERMISSION_READ | PERMISSION_WRITE))
    echo "Permissions: $permissions (READ + WRITE)"
    
    if has_permission $permissions $PERMISSION_READ; then
        echo "Has READ permission"
    fi
    
    if has_permission $permissions $PERMISSION_WRITE; then
        echo "Has WRITE permission"
    fi
    
    if ! has_permission $permissions $PERMISSION_EXECUTE; then
        echo "Does NOT have EXECUTE permission"
    fi
}

# ============================================================
# TRAFFIC LIGHT STATE MACHINE
# ============================================================

readonly LIGHT_RED=0
readonly LIGHT_YELLOW=1
readonly LIGHT_GREEN=2

get_light_action() {
    local light=$1
    case $light in
        $LIGHT_RED) echo "Stop" ;;
        $LIGHT_YELLOW) echo "Caution" ;;
        $LIGHT_GREEN) echo "Go" ;;
    esac
}

next_light() {
    local light=$1
    case $light in
        $LIGHT_RED) echo $LIGHT_GREEN ;;
        $LIGHT_YELLOW) echo $LIGHT_RED ;;
        $LIGHT_GREEN) echo $LIGHT_YELLOW ;;
    esac
}

demonstrate_state_machine() {
    echo ""
    echo "=== Traffic Light State Machine ==="
    
    local light=$LIGHT_RED
    for i in {1..4}; do
        echo "Light: $light - $(get_light_action $light)"
        light=$(next_light $light)
    done
}

# ============================================================
# ASSOCIATIVE ARRAY (Alternative enum representation)
# ============================================================

demonstrate_associative_enum() {
    echo ""
    echo "=== Associative Array Enum ==="
    
    declare -A LogLevel
    LogLevel[DEBUG]=0
    LogLevel[INFO]=1
    LogLevel[WARNING]=2
    LogLevel[ERROR]=3
    LogLevel[FATAL]=4
    
    echo "Log levels:"
    for level in "${!LogLevel[@]}"; do
        echo "  $level: ${LogLevel[$level]}"
    done
    
    local current_level="WARNING"
    echo ""
    echo "Current log level: $current_level (${LogLevel[$current_level]})"
}

# ============================================================
# VALIDATION (Ensure value is in enum)
# ============================================================

is_valid_day() {
    local day=$1
    if [ $day -ge 0 ] && [ $day -le 6 ]; then
        return 0  # valid
    else
        return 1  # invalid
    fi
}

demonstrate_validation() {
    echo ""
    echo "=== Enum Validation ==="
    
    local test_day=3
    if is_valid_day $test_day; then
        echo "Day $test_day is valid: $(day_to_string $test_day)"
    else
        echo "Day $test_day is invalid"
    fi
    
    test_day=99
    if is_valid_day $test_day; then
        echo "Day $test_day is valid: $(day_to_string $test_day)"
    else
        echo "Day $test_day is invalid"
    fi
}

# ============================================================
# MAIN - DEMONSTRATION
# ============================================================

main() {
    echo "=== Enums in Bash ==="
    echo ""
    
    demonstrate_basic_enum
    demonstrate_http_status
    demonstrate_days_of_week
    demonstrate_priority
    demonstrate_bitwise_flags
    demonstrate_state_machine
    demonstrate_associative_enum
    demonstrate_validation
    
    echo ""
    echo "💡 Bash Enum Simulation:"
    echo "   ✓ Use readonly variables for constants"
    echo "   ✓ Use case statements for conversions"
    echo "   ✓ Use bitwise operations for flags"
    echo "   ✓ Use associative arrays for name-value pairs"
    echo "   ✗ No native enum support"
    echo "   ✗ No compile-time type checking"
    
    echo ""
    echo "✓ Program completed successfully"
}

main
