program PointersDemo;

{$mode objfpc}{$H+}

uses
    SysUtils;

{ ============================================================
  BASIC POINTERS
  ============================================================ }

procedure DemonstrateBasicPointers;
var
    value: Integer;
    ptr: ^Integer;  { Pointer to Integer }
begin
    WriteLn('=== Basic Pointers ===');
    
    value := 42;
    ptr := @value;  { @ is the address-of operator }
    
    WriteLn('Value: ', value);
    WriteLn('Pointer points to: ', ptr^);  { ^ is the dereference operator }
    
    { Modify through pointer }
    ptr^ := 100;
    WriteLn('After ptr^ := 100, value is: ', value);
    
    { Check for nil }
    ptr := nil;
    if ptr = nil then
        WriteLn('Pointer is now nil');
end;

{ ============================================================
  DYNAMIC MEMORY ALLOCATION
  ============================================================ }

procedure DemonstrateDynamicAllocation;
var
    ptr: ^Integer;
    i: Integer;
begin
    WriteLn;
    WriteLn('=== Dynamic Memory Allocation ===');
    
    { Allocate memory }
    New(ptr);
    ptr^ := 999;
    WriteLn('Dynamically allocated value: ', ptr^);
    
    { Free memory }
    Dispose(ptr);
    WriteLn('✓ Memory freed');
    
    { Allocate array dynamically }
    type
        TIntArray = array[1..5] of Integer;
        PIntArray = ^TIntArray;
    var
        arrPtr: PIntArray;
    
    New(arrPtr);
    for i := 1 to 5 do
        arrPtr^[i] := i * 10;
    
    WriteLn('Dynamic array:');
    for i := 1 to 5 do
        WriteLn('  Element ', i, ': ', arrPtr^[i]);
    
    Dispose(arrPtr);
    WriteLn('✓ Array memory freed');
end;

{ ============================================================
  POINTER ARITHMETIC
  ============================================================ }

procedure DemonstratePointerArithmetic;
var
    arr: array[1..5] of Integer = (10, 20, 30, 40, 50);
    ptr: ^Integer;
    i: Integer;
begin
    WriteLn;
    WriteLn('=== Pointer Arithmetic ===');
    
    ptr := @arr[1];  { Point to first element }
    
    WriteLn('Array elements:');
    for i := 0 to 4 do
    begin
        WriteLn('  Element ', i + 1, ': ', ptr^);
        Inc(ptr);  { Move pointer to next element }
    end;
end;

{ ============================================================
  POINTERS TO RECORDS (Structs)
  ============================================================ }

type
    PPoint = ^TPoint;
    TPoint = record
        x: Integer;
        y: Integer;
    end;

procedure DemonstratePointersToRecords;
var
    p1: TPoint;
    ptr: PPoint;
    dynamicPoint: PPoint;
begin
    WriteLn;
    WriteLn('=== Pointers to Records ===');
    
    { Static allocation }
    p1.x := 10;
    p1.y := 20;
    ptr := @p1;
    WriteLn('Point via pointer: (', ptr^.x, ', ', ptr^.y, ')');
    
    { Dynamic allocation }
    New(dynamicPoint);
    dynamicPoint^.x := 30;
    dynamicPoint^.y := 40;
    WriteLn('Dynamic point: (', dynamicPoint^.x, ', ', dynamicPoint^.y, ')');
    Dispose(dynamicPoint);
    WriteLn('✓ Dynamic point freed');
end;

{ ============================================================
  LINKED LIST (Dynamic Data Structure)
  ============================================================ }

type
    PNode = ^TNode;
    TNode = record
        data: Integer;
        next: PNode;
    end;

procedure PrintList(head: PNode);
var
    current: PNode;
begin
    Write('List: ');
    current := head;
    while current <> nil do
    begin
        Write(current^.data, ' -> ');
        current := current^.next;
    end;
    WriteLn('nil');
end;

procedure FreeList(var head: PNode);
var
    current, temp: PNode;
begin
    current := head;
    while current <> nil do
    begin
        temp := current^.next;
        Dispose(current);
        current := temp;
    end;
    head := nil;
end;

procedure DemonstrateLinkedList;
var
    head, current, newNode: PNode;
    i: Integer;
begin
    WriteLn;
    WriteLn('=== Linked List with Pointers ===');
    
    { Create head node }
    New(head);
    head^.data := 10;
    head^.next := nil;
    
    { Add more nodes }
    current := head;
    for i := 20 to 40 do
    begin
        if i mod 10 = 0 then
        begin
            New(newNode);
            newNode^.data := i;
            newNode^.next := nil;
            current^.next := newNode;
            current := newNode;
        end;
    end;
    
    { Print list }
    PrintList(head);
    
    { Free all nodes }
    FreeList(head);
    WriteLn('✓ Linked list memory freed');
end;

{ ============================================================
  FUNCTION POINTERS (Procedural Types)
  ============================================================ }

type
    TMathOperation = function(a, b: Integer): Integer;

function Add(a, b: Integer): Integer;
begin
    Add := a + b;
end;

function Multiply(a, b: Integer): Integer;
begin
    Multiply := a * b;
end;

procedure DemonstrateFunctionPointers;
var
    operation: TMathOperation;
    result: Integer;
begin
    WriteLn;
    WriteLn('=== Function Pointers ===');
    
    operation := @Add;
    result := operation(5, 3);
    WriteLn('Add(5, 3) = ', result);
    
    operation := @Multiply;
    result := operation(5, 3);
    WriteLn('Multiply(5, 3) = ', result);
end;

{ ============================================================
  POINTER TO POINTER (Double Indirection)
  ============================================================ }

procedure DemonstratePointerToPointer;
var
    value: Integer;
    ptr1: ^Integer;
    ptr2: ^^Integer;  { Pointer to pointer }
begin
    WriteLn;
    WriteLn('=== Pointer to Pointer ===');
    
    value := 42;
    ptr1 := @value;
    ptr2 := @ptr1;
    
    WriteLn('Value: ', value);
    WriteLn('Via ptr1: ', ptr1^);
    WriteLn('Via ptr2: ', ptr2^^);
    
    { Modify through double pointer }
    ptr2^^ := 123;
    WriteLn('After ptr2^^ := 123, value is: ', value);
end;

{ ============================================================
  SWAP FUNCTION (Pass by Pointer)
  ============================================================ }

procedure Swap(a, b: ^Integer);
var
    temp: Integer;
begin
    temp := a^;
    a^ := b^;
    b^ := temp;
end;

procedure DemonstrateSwap;
var
    x, y: Integer;
begin
    WriteLn;
    WriteLn('=== Swap Function ===');
    
    x := 10;
    y := 20;
    WriteLn('Before swap: x = ', x, ', y = ', y);
    
    Swap(@x, @y);
    WriteLn('After swap: x = ', x, ', y = ', y);
end;

{ ============================================================
  COMMON PITFALLS
  ============================================================ }

procedure DemonstrateCommonPitfalls;
var
    ptr1, ptr2: ^Integer;
begin
    WriteLn;
    WriteLn('=== Common Pitfalls ===');
    
    { 1. Null pointer dereference }
    ptr1 := nil;
    WriteLn('Pitfall 1: Always check for nil before dereferencing');
    if ptr1 <> nil then
        WriteLn('  Value: ', ptr1^)
    else
        WriteLn('  Pointer is nil - cannot dereference!');
    
    { 2. Dangling pointer }
    New(ptr2);
    ptr2^ := 42;
    Dispose(ptr2);
    { ptr2 is now dangling - points to freed memory }
    ptr2 := nil;  { Good practice: set to nil after Dispose }
    WriteLn('Pitfall 2: Set pointer to nil after Dispose');
    
    { 3. Memory leak }
    WriteLn('Pitfall 3: Always Dispose dynamically allocated memory');
    WriteLn('  Use try-finally blocks to ensure cleanup');
end;

{ ============================================================
  MAIN PROGRAM
  ============================================================ }

begin
    WriteLn('=== Pointers in Pascal ===');
    WriteLn;
    
    DemonstrateBasicPointers;
    DemonstrateDynamicAllocation;
    DemonstratePointerArithmetic;
    DemonstratePointersToRecords;
    DemonstrateLinkedList;
    DemonstrateFunctionPointers;
    DemonstratePointerToPointer;
    DemonstrateSwap;
    DemonstrateCommonPitfalls;
    
    WriteLn;
    WriteLn('💡 Pascal Pointer Best Practices:');
    WriteLn('   ✓ Use New/Dispose for dynamic allocation');
    WriteLn('   ✓ Always check for nil before dereferencing');
    WriteLn('   ✓ Set pointers to nil after Dispose');
    WriteLn('   ✓ Use try-finally for guaranteed cleanup');
    WriteLn('   ✗ Avoid pointer arithmetic (use arrays instead)');
    
    WriteLn;
    WriteLn('✓ Program completed successfully');
end.
