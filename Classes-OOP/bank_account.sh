#!/bin/bash

#
# Bank Account System in Bash
# Demonstrates function-based organization (Bash doesn't have true OOP)
# Uses associative arrays to simulate object properties
#

# ============================================================
# "ACCOUNT CLASS" - Function-based approach
# ============================================================

# Account "constructor"
account_create() {
    local account_number="$1"
    local owner_name="$2"
    local initial_balance="$3"
    
    # Use associative arrays to store account data
    declare -gA ACCOUNT_${account_number//-/_}
    local -n account=ACCOUNT_${account_number//-/_}
    
    account[number]="$account_number"
    account[owner]="$owner_name"
    account[balance]="$initial_balance"
    account[type]="generic"
    
    echo "✓ Account created: $account_number for $owner_name"
}

# Account deposit "method"
account_deposit() {
    local account_number="$1"
    local amount="$2"
    local -n account=ACCOUNT_${account_number//-/_}
    
    if (( $(echo "$amount > 0" | bc -l) )); then
        account[balance]=$(echo "${account[balance]} + $amount" | bc -l)
        printf "✓ Deposited \$%.2f. New balance: \$%.2f\n" "$amount" "${account[balance]}"
    else
        echo "❌ Invalid deposit amount"
    fi
}

# Account withdraw "method"
account_withdraw() {
    local account_number="$1"
    local amount="$2"
    local -n account=ACCOUNT_${account_number//-/_}
    
    if (( $(echo "$amount > 0 && $amount <= ${account[balance]}" | bc -l) )); then
        account[balance]=$(echo "${account[balance]} - $amount" | bc -l)
        printf "✓ Withdrew \$%.2f. New balance: \$%.2f\n" "$amount" "${account[balance]}"
    else
        echo "❌ Insufficient funds or invalid amount"
    fi
}

# Account display "method"
account_display() {
    local account_number="$1"
    local -n account=ACCOUNT_${account_number//-/_}
    
    echo ""
    echo "=== Account Details ==="
    echo "Account Number: ${account[number]}"
    echo "Owner: ${account[owner]}"
    printf "Balance: \$%.2f\n" "${account[balance]}"
    
    # Show type-specific info if available
    if [ -n "${account[interest_rate]}" ]; then
        printf "Interest Rate: %.2f%%\n" "$(echo "${account[interest_rate]} * 100" | bc -l)"
    fi
    
    if [ -n "${account[overdraft]}" ]; then
        printf "Overdraft Limit: \$%.2f\n" "${account[overdraft]}"
    fi
}

# ============================================================
# "SAVINGS ACCOUNT CLASS" - Extended functionality
# ============================================================

savings_account_create() {
    local account_number="$1"
    local owner_name="$2"
    local initial_balance="$3"
    local interest_rate="$4"
    
    # Create base account
    account_create "$account_number" "$owner_name" "$initial_balance"
    
    # Add savings-specific properties
    local -n account=ACCOUNT_${account_number//-/_}
    account[type]="savings"
    account[interest_rate]="$interest_rate"
    
    printf "✓ Savings Account created with %.2f%% interest\n" "$(echo "$interest_rate * 100" | bc -l)"
}

# Savings account withdraw (with message)
savings_withdraw() {
    local account_number="$1"
    local amount="$2"
    
    echo "🏦 [Savings Account] Processing withdrawal..."
    account_withdraw "$account_number" "$amount"
}

# Apply interest to savings account
savings_apply_interest() {
    local account_number="$1"
    local -n account=ACCOUNT_${account_number//-/_}
    
    local interest=$(echo "${account[balance]} * ${account[interest_rate]}" | bc -l)
    account[balance]=$(echo "${account[balance]} + $interest" | bc -l)
    
    printf "✓ Interest applied: \$%.2f (rate: %.2f%%)\n" \
           "$interest" "$(echo "${account[interest_rate]} * 100" | bc -l)"
}

# ============================================================
# "CHECKING ACCOUNT CLASS" - Extended functionality
# ============================================================

checking_account_create() {
    local account_number="$1"
    local owner_name="$2"
    local initial_balance="$3"
    local overdraft_limit="$4"
    
    # Create base account
    account_create "$account_number" "$owner_name" "$initial_balance"
    
    # Add checking-specific properties
    local -n account=ACCOUNT_${account_number//-/_}
    account[type]="checking"
    account[overdraft]="$overdraft_limit"
    
    printf "✓ Checking Account created with \$%.2f overdraft\n" "$overdraft_limit"
}

# Checking account withdraw (with overdraft support)
checking_withdraw() {
    local account_number="$1"
    local amount="$2"
    local -n account=ACCOUNT_${account_number//-/_}
    
    local available_balance=$(echo "${account[balance]} + ${account[overdraft]}" | bc -l)
    
    echo "🏦 [Checking Account] Processing withdrawal..."
    
    if (( $(echo "$amount > 0 && $amount <= $available_balance" | bc -l) )); then
        account[balance]=$(echo "${account[balance]} - $amount" | bc -l)
        printf "✓ Withdrew \$%.2f. New balance: \$%.2f\n" "$amount" "${account[balance]}"
        
        if (( $(echo "${account[balance]} < 0" | bc -l) )); then
            local overdraft_used=$(echo "0 - ${account[balance]}" | bc -l)
            printf "⚠️  Overdraft used: \$%.2f\n" "$overdraft_used"
        fi
    else
        echo "❌ Exceeds overdraft limit"
    fi
}

# ============================================================
# MAIN - DEMONSTRATION
# ============================================================

main() {
    echo "=== Bank Account System (Bash Function-based) ==="
    echo ""
    
    # Create accounts
    savings_account_create "SAV001" "Alice Johnson" 5000.00 0.03
    checking_account_create "CHK001" "Bob Smith" 1000.00 500.00
    
    echo ""
    echo "--- Savings Account Operations ---"
    account_deposit "SAV001" 500.00
    savings_apply_interest "SAV001"
    account_display "SAV001"
    
    echo ""
    echo "--- Checking Account Operations ---"
    checking_withdraw "CHK001" 1200.00  # Uses overdraft
    account_deposit "CHK001" 300.00
    account_display "CHK001"
    
    echo ""
    echo "--- Account Summary ---"
    declare -gA ACCOUNT_SAV001
    declare -gA ACCOUNT_CHK001
    local -n sav=ACCOUNT_SAV001
    local -n chk=ACCOUNT_CHK001
    
    echo "Savings Account Type: ${sav[type]}"
    echo "Checking Account Type: ${chk[type]}"
    
    local total_balance=$(echo "${sav[balance]} + ${chk[balance]}" | bc -l)
    printf "\nTotal balance across all accounts: \$%.2f\n" "$total_balance"
    
    echo ""
    echo "✓ Program completed successfully"
}

# Run main function
main "$@"
