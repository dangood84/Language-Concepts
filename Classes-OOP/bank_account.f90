! Bank Account System in Fortran 2003/2008
! Demonstrates OOP with derived types and type-bound procedures

program bank_account_system
    implicit none
    
    ! Test the bank account system
    call main()
    
contains

    ! ============================================================
    ! BASE ACCOUNT TYPE (Similar to a class)
    ! ============================================================
    
    type :: Account
        character(len=20) :: accountNumber
        character(len=100) :: ownerName
        real :: balance
    contains
        procedure :: init => account_init
        procedure :: deposit => account_deposit
        procedure :: withdraw => account_withdraw
        procedure :: display => account_display
        procedure :: getBalance => account_get_balance
    end type Account
    
    ! Account "methods"
    subroutine account_init(this, accountNumber, ownerName, initialBalance)
        class(Account), intent(inout) :: this
        character(len=*), intent(in) :: accountNumber, ownerName
        real, intent(in) :: initialBalance
        
        this%accountNumber = accountNumber
        this%ownerName = ownerName
        this%balance = initialBalance
        print '(A,A,A,A)', '✓ Account created: ', trim(accountNumber), ' for ', trim(ownerName)
    end subroutine account_init
    
    subroutine account_deposit(this, amount)
        class(Account), intent(inout) :: this
        real, intent(in) :: amount
        
        if (amount > 0.0) then
            this%balance = this%balance + amount
            print '(A,F8.2,A,F8.2)', '✓ Deposited $', amount, '. New balance: $', this%balance
        else
            print *, '❌ Invalid deposit amount'
        end if
    end subroutine account_deposit
    
    subroutine account_withdraw(this, amount)
        class(Account), intent(inout) :: this
        real, intent(in) :: amount
        
        if (amount > 0.0 .and. amount <= this%balance) then
            this%balance = this%balance - amount
            print '(A,F8.2,A,F8.2)', '✓ Withdrew $', amount, '. New balance: $', this%balance
        else
            print *, '❌ Insufficient funds or invalid amount'
        end if
    end subroutine account_withdraw
    
    subroutine account_display(this)
        class(Account), intent(in) :: this
        
        print *
        print *, '=== Account Details ==='
        print '(A,A)', 'Account Number: ', trim(this%accountNumber)
        print '(A,A)', 'Owner: ', trim(this%ownerName)
        print '(A,F8.2)', 'Balance: $', this%balance
    end subroutine account_display
    
    real function account_get_balance(this)
        class(Account), intent(in) :: this
        account_get_balance = this%balance
    end function account_get_balance
    
    ! ============================================================
    ! SAVINGS ACCOUNT TYPE (Inheritance)
    ! ============================================================
    
    type, extends(Account) :: SavingsAccount
        real :: interestRate
    contains
        procedure :: init_savings => savings_init
        procedure :: withdraw => savings_withdraw  ! Override
        procedure :: display => savings_display    ! Override
        procedure :: applyInterest => savings_apply_interest
    end type SavingsAccount
    
    subroutine savings_init(this, accountNumber, ownerName, initialBalance, interestRate)
        class(SavingsAccount), intent(inout) :: this
        character(len=*), intent(in) :: accountNumber, ownerName
        real, intent(in) :: initialBalance, interestRate
        
        call this%init(accountNumber, ownerName, initialBalance)
        this%interestRate = interestRate
        print '(A,F5.2,A)', '✓ Savings Account created with ', interestRate * 100.0, '% interest'
    end subroutine savings_init
    
    subroutine savings_withdraw(this, amount)
        class(SavingsAccount), intent(inout) :: this
        
        print *, '🏦 [Savings Account] Processing withdrawal...'
        call account_withdraw(this, amount)
    end subroutine savings_withdraw
    
    subroutine savings_apply_interest(this)
        class(SavingsAccount), intent(inout) :: this
        real :: interest
        
        interest = this%balance * this%interestRate
        this%balance = this%balance + interest
        print '(A,F8.2,A,F5.2,A)', '✓ Interest applied: $', interest, ' (rate: ', &
              this%interestRate * 100.0, '%)'
    end subroutine savings_apply_interest
    
    subroutine savings_display(this)
        class(SavingsAccount), intent(in) :: this
        
        print *
        print *, '=== Savings Account Details ==='
        print '(A,A)', 'Account Number: ', trim(this%accountNumber)
        print '(A,A)', 'Owner: ', trim(this%ownerName)
        print '(A,F8.2)', 'Balance: $', this%balance
        print '(A,F5.2,A)', 'Interest Rate: ', this%interestRate * 100.0, '%'
    end subroutine savings_display
    
    ! ============================================================
    ! CHECKING ACCOUNT TYPE (Inheritance)
    ! ============================================================
    
    type, extends(Account) :: CheckingAccount
        real :: overdraftLimit
    contains
        procedure :: init_checking => checking_init
        procedure :: withdraw => checking_withdraw  ! Override
        procedure :: display => checking_display    ! Override
    end type CheckingAccount
    
    subroutine checking_init(this, accountNumber, ownerName, initialBalance, overdraftLimit)
        class(CheckingAccount), intent(inout) :: this
        character(len=*), intent(in) :: accountNumber, ownerName
        real, intent(in) :: initialBalance, overdraftLimit
        
        call this%init(accountNumber, ownerName, initialBalance)
        this%overdraftLimit = overdraftLimit
        print '(A,F8.2,A)', '✓ Checking Account created with $', overdraftLimit, ' overdraft'
    end subroutine checking_init
    
    subroutine checking_withdraw(this, amount)
        class(CheckingAccount), intent(inout) :: this
        real :: availableBalance
        
        availableBalance = this%balance + this%overdraftLimit
        
        print *, '🏦 [Checking Account] Processing withdrawal...'
        
        if (amount > 0.0 .and. amount <= availableBalance) then
            this%balance = this%balance - amount
            print '(A,F8.2,A,F8.2)', '✓ Withdrew $', amount, '. New balance: $', this%balance
            
            if (this%balance < 0.0) then
                print '(A,F8.2)', '⚠️  Overdraft used: $', -this%balance
            end if
        else
            print *, '❌ Exceeds overdraft limit'
        end if
    end subroutine checking_withdraw
    
    subroutine checking_display(this)
        class(CheckingAccount), intent(in) :: this
        
        print *
        print *, '=== Checking Account Details ==='
        print '(A,A)', 'Account Number: ', trim(this%accountNumber)
        print '(A,A)', 'Owner: ', trim(this%ownerName)
        print '(A,F8.2)', 'Balance: $', this%balance
        print '(A,F8.2)', 'Overdraft Limit: $', this%overdraftLimit
    end subroutine checking_display
    
    ! ============================================================
    ! MAIN SUBROUTINE - DEMONSTRATION
    ! ============================================================
    
    subroutine main()
        type(SavingsAccount) :: savings
        type(CheckingAccount) :: checking
        
        print *, '=== Bank Account System (Fortran 2003 OOP) ==='
        print *
        
        ! Initialize accounts
        call savings%init_savings('SAV001', 'Alice Johnson', 5000.0, 0.03)
        call checking%init_checking('CHK001', 'Bob Smith', 1000.0, 500.0)
        
        print *
        print *, '--- Savings Account Operations ---'
        call savings%deposit(500.0)
        call savings%applyInterest()
        call savings%display()
        
        print *
        print *, '--- Checking Account Operations ---'
        call checking%withdraw(1200.0)  ! Uses overdraft
        call checking%deposit(300.0)
        call checking%display()
        
        print *
        print *, '✓ Program completed successfully'
    end subroutine main

end program bank_account_system
