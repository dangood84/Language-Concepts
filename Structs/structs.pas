program StructsDemo;

{$mode objfpc}{$H+}

uses
    SysUtils;

{ ============================================================
  BASIC RECORD TYPE (Pascal's struct)
  ============================================================ }

type
    TPoint = record
        x: Integer;
        y: Integer;
    end;

procedure DemonstrateBasicRecord;
var
    p1, p2: TPoint;
begin
    WriteLn('=== Basic Record Type ===');
    
    p1.x := 10;
    p1.y := 20;
    WriteLn('Point p1: (', p1.x, ', ', p1.y, ')');
    
    p2.x := 5;
    p2.y := 15;
    WriteLn('Point p2: (', p2.x, ', ', p2.y, ')');
end;

{ ============================================================
  NESTED RECORDS
  ============================================================ }

type
    TAddress = record
        street: string[50];
        city: string[30];
        zipCode: string[10];
    end;
    
    TPerson = record
        name: string[30];
        age: Integer;
        address: TAddress;  { Nested record }
    end;

procedure DemonstrateNestedRecords;
var
    person: TPerson;
begin
    WriteLn;
    WriteLn('=== Nested Records ===');
    
    person.name := 'Alice Johnson';
    person.age := 30;
    person.address.street := '123 Main St';
    person.address.city := 'Springfield';
    person.address.zipCode := '12345';
    
    WriteLn('Name: ', person.name);
    WriteLn('Age: ', person.age);
    WriteLn('Address: ', person.address.street, ', ', 
            person.address.city, ' ', person.address.zipCode);
end;

{ ============================================================
  RECORD WITH METHODS (Object Pascal)
  ============================================================ }

type
    TRectangle = record
        width: Real;
        height: Real;
        function Area: Real;
        function Perimeter: Real;
        procedure Print;
    end;

function TRectangle.Area: Real;
begin
    Area := width * height;
end;

function TRectangle.Perimeter: Real;
begin
    Perimeter := 2 * (width + height);
end;

procedure TRectangle.Print;
begin
    WriteLn('Rectangle(', width:0:1, 'x', height:0:1, ')');
end;

procedure DemonstrateRecordWithMethods;
var
    rect: TRectangle;
begin
    WriteLn;
    WriteLn('=== Record with Methods ===');
    
    rect.width := 10.0;
    rect.height := 5.0;
    rect.Print;
    WriteLn('Area: ', rect.Area:0:2);
    WriteLn('Perimeter: ', rect.Perimeter:0:2);
end;

{ ============================================================
  ARRAY OF RECORDS
  ============================================================ }

type
    TAccount = record
        id: Integer;
        name: string[30];
        balance: Real;
    end;

procedure DemonstrateArrayOfRecords;
var
    accounts: array[1..3] of TAccount;
    i: Integer;
begin
    WriteLn;
    WriteLn('=== Array of Records ===');
    
    { Initialize array }
    accounts[1].id := 1001;
    accounts[1].name := 'Alice';
    accounts[1].balance := 5000.50;
    
    accounts[2].id := 1002;
    accounts[2].name := 'Bob';
    accounts[2].balance := 3200.75;
    
    accounts[3].id := 1003;
    accounts[3].name := 'Charlie';
    accounts[3].balance := 7500.00;
    
    WriteLn('Bank Accounts:');
    for i := 1 to 3 do
    begin
        WriteLn('  ID: ', accounts[i].id, ', Name: ', accounts[i].name,
                ', Balance: $', accounts[i].balance:0:2);
    end;
end;

{ ============================================================
  RECORD INITIALIZATION
  ============================================================ }

type
    TPoint3D = record
        x, y, z: Real;
    end;

procedure DemonstrateRecordInitialization;
var
    p: TPoint3D;
begin
    WriteLn;
    WriteLn('=== Record Initialization ===');
    
    { Initialize with default values }
    p.x := 0;
    p.y := 0;
    p.z := 0;
    
    { Assign new values }
    p.x := 1.5;
    p.y := 2.5;
    p.z := 3.5;
    
    WriteLn('Point3D: (', p.x:0:1, ', ', p.y:0:1, ', ', p.z:0:1, ')');
end;

{ ============================================================
  RECORD COPYING
  ============================================================ }

procedure DemonstrateRecordCopying;
var
    p1, p2: TPoint;
begin
    WriteLn;
    WriteLn('=== Record Copying ===');
    
    p1.x := 10;
    p1.y := 20;
    
    { Copy entire record }
    p2 := p1;
    
    WriteLn('Original: (', p1.x, ', ', p1.y, ')');
    WriteLn('Copy: (', p2.x, ', ', p2.y, ')');
    
    { Modify copy }
    p2.x := 30;
    WriteLn('After modifying copy:');
    WriteLn('  Original: (', p1.x, ', ', p1.y, ')');
    WriteLn('  Copy: (', p2.x, ', ', p2.y, ')');
end;

{ ============================================================
  RECORD COMPARISON
  ============================================================ }

function PointsEqual(const p1, p2: TPoint): Boolean;
begin
    PointsEqual := (p1.x = p2.x) and (p1.y = p2.y);
end;

procedure DemonstrateRecordComparison;
var
    p1, p2, p3: TPoint;
begin
    WriteLn;
    WriteLn('=== Record Comparison ===');
    
    p1.x := 10;
    p1.y := 20;
    
    p2.x := 10;
    p2.y := 20;
    
    p3.x := 15;
    p3.y := 25;
    
    WriteLn('p1 equals p2: ', PointsEqual(p1, p2));
    WriteLn('p1 equals p3: ', PointsEqual(p1, p3));
end;

{ ============================================================
  PACKED RECORDS (Memory optimization)
  ============================================================ }

type
    TUnpackedRecord = record
        a: Byte;
        b: Integer;
        c: Byte;
    end;
    
    TPackedRecord = packed record
        a: Byte;
        b: Integer;
        c: Byte;
    end;

procedure DemonstratePackedRecords;
begin
    WriteLn;
    WriteLn('=== Packed Records ===');
    WriteLn('Unpacked record size: ', SizeOf(TUnpackedRecord), ' bytes');
    WriteLn('Packed record size: ', SizeOf(TPackedRecord), ' bytes');
    WriteLn('(Packed records remove padding for smaller memory footprint)');
end;

{ ============================================================
  WITH STATEMENT (Shorthand for record access)
  ============================================================ }

procedure DemonstrateWithStatement;
var
    person: TPerson;
begin
    WriteLn;
    WriteLn('=== WITH Statement ===');
    
    with person do
    begin
        name := 'Bob Smith';
        age := 35;
        address.street := '456 Elm St';
        address.city := 'Portland';
        address.zipCode := '97201';
    end;
    
    WriteLn('Person: ', person.name, ', Age ', person.age);
    WriteLn('Lives in: ', person.address.city);
end;

{ ============================================================
  MAIN PROGRAM
  ============================================================ }

begin
    WriteLn('=== Structures in Pascal ===');
    WriteLn;
    
    DemonstrateBasicRecord;
    DemonstrateNestedRecords;
    DemonstrateRecordWithMethods;
    DemonstrateArrayOfRecords;
    DemonstrateRecordInitialization;
    DemonstrateRecordCopying;
    DemonstrateRecordComparison;
    DemonstratePackedRecords;
    DemonstrateWithStatement;
    
    WriteLn;
    WriteLn('✓ Program completed successfully');
end.
