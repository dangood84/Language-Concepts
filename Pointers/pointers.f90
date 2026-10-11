! Pointers in Fortran (Fortran 90+)
! Demonstrates pointer targets, pointer association, and dynamic memory

program pointers_demo
    implicit none
    
    call demonstrate_basic_pointers()
    call demonstrate_pointer_arithmetic()
    call demonstrate_dynamic_allocation()
    call demonstrate_pointer_to_array()
    call demonstrate_linked_list()
    
    print *, ''
    print *, '✓ Program completed successfully'
    
contains

    ! ============================================================
    ! BASIC POINTERS (Pointer to Target)
    ! ============================================================
    
    subroutine demonstrate_basic_pointers()
        integer, target :: value
        integer, pointer :: ptr
        
        print *, '=== Basic Pointers ==='
        
        value = 42
        ptr => value  ! Associate pointer with target
        
        print '(A,I0)', 'Value: ', value
        print '(A,I0)', 'Pointer points to: ', ptr
        
        ! Modify through pointer
        ptr = 100
        print '(A,I0)', 'After ptr = 100, value is: ', value
        
        ! Check if pointer is associated
        if (associated(ptr)) then
            print *, 'Pointer is associated'
        end if
        
        ! Nullify pointer
        nullify(ptr)
        if (.not. associated(ptr)) then
            print *, 'Pointer is now null'
        end if
    end subroutine

    ! ============================================================
    ! POINTER ARITHMETIC (Array pointers)
    ! ============================================================
    
    subroutine demonstrate_pointer_arithmetic()
        integer, target :: arr(5) = [10, 20, 30, 40, 50]
        integer, pointer :: ptr(:)
        integer :: i
        
        print *, ''
        print *, '=== Pointer to Array ==='
        
        ptr => arr  ! Point to entire array
        
        print *, 'Array elements:'
        do i = 1, 5
            print '(A,I0,A,I0)', '  arr(', i, ') = ', ptr(i)
        end do
        
        ! Point to subarray
        ptr => arr(2:4)
        print *, 'Subarray (2:4):'
        do i = 1, size(ptr)
            print '(A,I0,A,I0)', '  ptr(', i, ') = ', ptr(i)
        end do
    end subroutine

    ! ============================================================
    ! DYNAMIC MEMORY ALLOCATION
    ! ============================================================
    
    subroutine demonstrate_dynamic_allocation()
        integer, pointer :: dynamic_ptr
        integer, pointer :: dynamic_array(:)
        integer :: stat
        
        print *, ''
        print *, '=== Dynamic Memory Allocation ==='
        
        ! Allocate single variable
        allocate(dynamic_ptr, stat=stat)
        if (stat == 0) then
            dynamic_ptr = 999
            print '(A,I0)', 'Dynamically allocated value: ', dynamic_ptr
            deallocate(dynamic_ptr)
            print *, '✓ Memory deallocated'
        end if
        
        ! Allocate array
        allocate(dynamic_array(5), stat=stat)
        if (stat == 0) then
            dynamic_array = [1, 2, 3, 4, 5]
            print *, 'Dynamically allocated array:', dynamic_array
            deallocate(dynamic_array)
            print *, '✓ Array memory deallocated'
        end if
    end subroutine

    ! ============================================================
    ! POINTER TO ARRAY WITH BOUNDS
    ! ============================================================
    
    subroutine demonstrate_pointer_to_array()
        real, target :: matrix(3, 3)
        real, pointer :: row_ptr(:)
        integer :: i, j
        
        print *, ''
        print *, '=== Pointer to Matrix Row ==='
        
        ! Initialize matrix
        do i = 1, 3
            do j = 1, 3
                matrix(i, j) = real(i * 10 + j)
            end do
        end do
        
        ! Point to second row
        row_ptr => matrix(2, :)
        print *, 'Second row of matrix:', row_ptr
    end subroutine

    ! ============================================================
    ! LINKED LIST (Dynamic Data Structure)
    ! ============================================================
    
    subroutine demonstrate_linked_list()
        type :: Node
            integer :: data
            type(Node), pointer :: next
        end type Node
        
        type(Node), pointer :: head, current, new_node
        integer :: i
        
        print *, ''
        print *, '=== Linked List with Pointers ==='
        
        ! Create head node
        allocate(head)
        head%data = 10
        nullify(head%next)
        
        ! Add more nodes
        current => head
        do i = 20, 40, 10
            allocate(new_node)
            new_node%data = i
            nullify(new_node%next)
            current%next => new_node
            current => new_node
        end do
        
        ! Traverse and print
        print *, 'Linked list:'
        current => head
        do while (associated(current))
            print '(A,I0,A)', '  ', current%data, ' ->'
            current => current%next
        end do
        print *, '  null'
        
        ! Clean up (deallocate all nodes)
        current => head
        do while (associated(current))
            new_node => current%next
            deallocate(current)
            current => new_node
        end do
        print *, '✓ Linked list memory freed'
    end subroutine

end program pointers_demo
