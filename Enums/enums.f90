! Enums in Fortran (Enumerators - Fortran 2003+)
! Demonstrates enumerator types for named constants

program enums_demo
    implicit none
    
    call demonstrate_basic_enum()
    call demonstrate_http_status()
    call demonstrate_days_of_week()
    call demonstrate_custom_values()
    
    print *, ''
    print *, '✓ Program completed successfully'
    
contains

    ! ============================================================
    ! BASIC ENUMERATION
    ! ============================================================
    
    subroutine demonstrate_basic_enum()
        enum, bind(c)
            enumerator :: RED = 0
            enumerator :: GREEN = 1
            enumerator :: BLUE = 2
        end enum
        
        integer :: color
        
        print *, '=== Basic Enumeration ==='
        
        color = RED
        print '(A,I0)', 'RED value: ', color
        
        color = GREEN
        print '(A,I0)', 'GREEN value: ', color
        
        color = BLUE
        print '(A,I0)', 'BLUE value: ', color
    end subroutine

    ! ============================================================
    ! HTTP STATUS CODES
    ! ============================================================
    
    subroutine demonstrate_http_status()
        enum, bind(c)
            enumerator :: HTTP_OK = 200
            enumerator :: HTTP_CREATED = 201
            enumerator :: HTTP_BAD_REQUEST = 400
            enumerator :: HTTP_UNAUTHORIZED = 401
            enumerator :: HTTP_NOT_FOUND = 404
            enumerator :: HTTP_SERVER_ERROR = 500
        end enum
        
        integer :: status
        
        print *, ''
        print *, '=== HTTP Status Codes ==='
        
        status = HTTP_OK
        call print_http_status(status)
        
        status = HTTP_NOT_FOUND
        call print_http_status(status)
        
        status = HTTP_SERVER_ERROR
        call print_http_status(status)
    end subroutine
    
    subroutine print_http_status(status)
        integer, intent(in) :: status
        
        select case (status)
            case (200)
                print *, 'Status: 200 OK'
            case (201)
                print *, 'Status: 201 Created'
            case (400)
                print *, 'Status: 400 Bad Request'
            case (401)
                print *, 'Status: 401 Unauthorized'
            case (404)
                print *, 'Status: 404 Not Found'
            case (500)
                print *, 'Status: 500 Internal Server Error'
            case default
                print *, 'Status: Unknown'
        end select
    end subroutine

    ! ============================================================
    ! DAYS OF WEEK
    ! ============================================================
    
    subroutine demonstrate_days_of_week()
        enum, bind(c)
            enumerator :: MONDAY = 0
            enumerator :: TUESDAY = 1
            enumerator :: WEDNESDAY = 2
            enumerator :: THURSDAY = 3
            enumerator :: FRIDAY = 4
            enumerator :: SATURDAY = 5
            enumerator :: SUNDAY = 6
        end enum
        
        integer :: today
        
        print *, ''
        print *, '=== Days of Week ==='
        
        today = WEDNESDAY
        call print_day_name(today)
        
        if (today >= MONDAY .and. today <= FRIDAY) then
            print *, 'It''s a weekday'
        else
            print *, 'It''s a weekend'
        end if
    end subroutine
    
    subroutine print_day_name(day)
        integer, intent(in) :: day
        
        select case (day)
            case (0)
                print *, 'Day: Monday'
            case (1)
                print *, 'Day: Tuesday'
            case (2)
                print *, 'Day: Wednesday'
            case (3)
                print *, 'Day: Thursday'
            case (4)
                print *, 'Day: Friday'
            case (5)
                print *, 'Day: Saturday'
            case (6)
                print *, 'Day: Sunday'
            case default
                print *, 'Day: Unknown'
        end select
    end subroutine

    ! ============================================================
    ! CUSTOM VALUES (Non-sequential)
    ! ============================================================
    
    subroutine demonstrate_custom_values()
        enum, bind(c)
            enumerator :: LOW = 1
            enumerator :: MEDIUM = 5
            enumerator :: HIGH = 10
            enumerator :: CRITICAL = 100
        end enum
        
        integer :: priority
        
        print *, ''
        print *, '=== Custom Enum Values ==='
        
        priority = LOW
        print '(A,I0)', 'LOW priority: ', priority
        
        priority = MEDIUM
        print '(A,I0)', 'MEDIUM priority: ', priority
        
        priority = HIGH
        print '(A,I0)', 'HIGH priority: ', priority
        
        priority = CRITICAL
        print '(A,I0)', 'CRITICAL priority: ', priority
        
        ! Compare priorities
        if (HIGH > MEDIUM) then
            print *, 'HIGH priority is greater than MEDIUM'
        end if
    end subroutine

end program enums_demo
