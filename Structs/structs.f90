! Structures in Fortran (Derived Types)
! Demonstrates derived types, type-bound procedures, and nested structures

program structs_demo
    implicit none
    
    call demonstrate_basic_derived_type()
    call demonstrate_nested_types()
    call demonstrate_type_bound_procedures()
    call demonstrate_array_of_types()
    
    print *, ''
    print *, '✓ Program completed successfully'
    
contains

    ! ============================================================
    ! BASIC DERIVED TYPE (Fortran's struct)
    ! ============================================================
    
    subroutine demonstrate_basic_derived_type()
        ! Define derived type
        type :: Point
            real :: x
            real :: y
        end type Point
        
        ! Declare and initialize
        type(Point) :: p1, p2
        
        print *, '=== Basic Derived Types ==='
        
        p1%x = 10.0
        p1%y = 20.0
        print '(A,F6.1,A,F6.1,A)', 'Point p1: (', p1%x, ', ', p1%y, ')'
        
        ! Initialize with constructor
        p2 = Point(5.0, 15.0)
        print '(A,F6.1,A,F6.1,A)', 'Point p2: (', p2%x, ', ', p2%y, ')'
    end subroutine

    ! ============================================================
    ! NESTED DERIVED TYPES
    ! ============================================================
    
    subroutine demonstrate_nested_types()
        type :: Address
            character(len=50) :: street
            character(len=30) :: city
            character(len=10) :: zipCode
        end type Address
        
        type :: Person
            character(len=30) :: name
            integer :: age
            type(Address) :: address  ! Nested type
        end type Person
        
        type(Person) :: person1
        
        print *, ''
        print *, '=== Nested Derived Types ==='
        
        person1%name = 'Alice Johnson'
        person1%age = 30
        person1%address%street = '123 Main St'
        person1%address%city = 'Springfield'
        person1%address%zipCode = '12345'
        
        print '(A,A)', 'Name: ', trim(person1%name)
        print '(A,I0)', 'Age: ', person1%age
        print '(A,A,A,A,1X,A)', 'Address: ', trim(person1%address%street), ', ', &
              trim(person1%address%city), trim(person1%address%zipCode)
    end subroutine

    ! ============================================================
    ! TYPE-BOUND PROCEDURES (Methods)
    ! ============================================================
    
    subroutine demonstrate_type_bound_procedures()
        type :: Rectangle
            real :: width
            real :: height
        contains
            procedure :: area => rectangle_area
            procedure :: perimeter => rectangle_perimeter
            procedure :: print => rectangle_print
        end type Rectangle
        
        type(Rectangle) :: rect
        
        print *, ''
        print *, '=== Type-Bound Procedures ==='
        
        rect = Rectangle(10.0, 5.0)
        call rect%print()
        print '(A,F8.2)', 'Area: ', rect%area()
        print '(A,F8.2)', 'Perimeter: ', rect%perimeter()
    end subroutine
    
    function rectangle_area(this) result(area)
        class(Rectangle), intent(in) :: this
        real :: area
        area = this%width * this%height
    end function
    
    function rectangle_perimeter(this) result(perimeter)
        class(Rectangle), intent(in) :: this
        real :: perimeter
        perimeter = 2.0 * (this%width + this%height)
    end function
    
    subroutine rectangle_print(this)
        class(Rectangle), intent(in) :: this
        print '(A,F6.1,A,F6.1,A)', 'Rectangle(', this%width, 'x', this%height, ')'
    end subroutine

    ! ============================================================
    ! ARRAY OF DERIVED TYPES
    ! ============================================================
    
    subroutine demonstrate_array_of_types()
        type :: Account
            integer :: id
            character(len=30) :: name
            real :: balance
        end type Account
        
        type(Account), dimension(3) :: accounts
        integer :: i
        
        print *, ''
        print *, '=== Array of Derived Types ==='
        
        ! Initialize array
        accounts(1) = Account(1001, 'Alice', 5000.50)
        accounts(2) = Account(1002, 'Bob', 3200.75)
        accounts(3) = Account(1003, 'Charlie', 7500.00)
        
        print *, 'Bank Accounts:'
        do i = 1, 3
            print '(A,I0,A,A,A,F9.2)', '  ID: ', accounts(i)%id, &
                  ', Name: ', trim(accounts(i)%name), &
                  ', Balance: $', accounts(i)%balance
        end do
    end subroutine

end program structs_demo
