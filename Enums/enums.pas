program EnumsDemo;

{$mode objfpc}{$H+}

uses
    SysUtils;

{ ============================================================
  BASIC ENUMERATION
  ============================================================ }

type
    TColor = (RED, GREEN, BLUE);

procedure DemonstrateBasicEnum;
var
    color: TColor;
begin
    WriteLn('=== Basic Enumeration ===');
    
    color := RED;
    WriteLn('Color: RED, Ordinal: ', Ord(color));
    
    color := GREEN;
    WriteLn('Color: GREEN, Ordinal: ', Ord(color));
    
    color := BLUE;
    WriteLn('Color: BLUE, Ordinal: ', Ord(color));
end;

{ ============================================================
  HTTP STATUS CODES (Custom values using constants)
  ============================================================ }

const
    HTTP_OK = 200;
    HTTP_CREATED = 201;
    HTTP_BAD_REQUEST = 400;
    HTTP_UNAUTHORIZED = 401;
    HTTP_NOT_FOUND = 404;
    HTTP_SERVER_ERROR = 500;

function HttpStatusToString(status: Integer): string;
begin
    case status of
        200: Result := '200 OK';
        201: Result := '201 Created';
        400: Result := '400 Bad Request';
        401: Result := '401 Unauthorized';
        404: Result := '404 Not Found';
        500: Result := '500 Internal Server Error';
    else
        Result := 'Unknown Status';
    end;
end;

procedure DemonstrateHttpStatus;
var
    status: Integer;
begin
    WriteLn;
    WriteLn('=== HTTP Status Codes ===');
    
    status := HTTP_OK;
    WriteLn('Status: ', HttpStatusToString(status));
    
    status := HTTP_NOT_FOUND;
    WriteLn('Status: ', HttpStatusToString(status));
    
    status := HTTP_SERVER_ERROR;
    WriteLn('Status: ', HttpStatusToString(status));
end;

{ ============================================================
  DAYS OF WEEK
  ============================================================ }

type
    TDayOfWeek = (MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY);

function DayToString(day: TDayOfWeek): string;
begin
    case day of
        MONDAY: Result := 'Monday';
        TUESDAY: Result := 'Tuesday';
        WEDNESDAY: Result := 'Wednesday';
        THURSDAY: Result := 'Thursday';
        FRIDAY: Result := 'Friday';
        SATURDAY: Result := 'Saturday';
        SUNDAY: Result := 'Sunday';
    end;
end;

function IsWeekday(day: TDayOfWeek): Boolean;
begin
    Result := day in [MONDAY..FRIDAY];
end;

procedure DemonstrateDaysOfWeek;
var
    today: TDayOfWeek;
begin
    WriteLn;
    WriteLn('=== Days of Week ===');
    
    today := WEDNESDAY;
    WriteLn('Today: ', DayToString(today));
    WriteLn('Ordinal value: ', Ord(today));
    
    if IsWeekday(today) then
        WriteLn('It''s a weekday')
    else
        WriteLn('It''s a weekend');
    
    { Iterate through all days }
    WriteLn;
    WriteLn('All days:');
    for today := MONDAY to SUNDAY do
        WriteLn('  ', DayToString(today));
end;

{ ============================================================
  ENUM WITH RANGES
  ============================================================ }

type
    TPriority = (LOW, MEDIUM, HIGH, CRITICAL);

procedure DemonstrateEnumRanges;
var
    priority: TPriority;
begin
    WriteLn;
    WriteLn('=== Enum with Ranges ===');
    
    priority := HIGH;
    WriteLn('Priority: HIGH, Ordinal: ', Ord(priority));
    
    { Range checking }
    if priority in [HIGH, CRITICAL] then
        WriteLn('This is a high-priority item');
    
    { Comparison }
    if priority > MEDIUM then
        WriteLn('Priority is above MEDIUM');
end;

{ ============================================================
  ENUM IN SETS
  ============================================================ }

type
    TFilePermission = (READ, WRITE, EXECUTE);
    TFilePermissions = set of TFilePermission;

procedure DemonstrateEnumSets;
var
    permissions: TFilePermissions;
begin
    WriteLn;
    WriteLn('=== Enum in Sets (Bitwise Flags) ===');
    
    { Create set with multiple values }
    permissions := [READ, WRITE];
    
    if READ in permissions then
        WriteLn('Has READ permission');
    
    if WRITE in permissions then
        WriteLn('Has WRITE permission');
    
    if not (EXECUTE in permissions) then
        WriteLn('Does NOT have EXECUTE permission');
    
    { Add permission }
    Include(permissions, EXECUTE);
    WriteLn;
    WriteLn('After adding EXECUTE:');
    if EXECUTE in permissions then
        WriteLn('Now has EXECUTE permission');
    
    { Remove permission }
    Exclude(permissions, WRITE);
    WriteLn;
    WriteLn('After removing WRITE:');
    if not (WRITE in permissions) then
        WriteLn('No longer has WRITE permission');
end;

{ ============================================================
  TRAFFIC LIGHT STATE MACHINE
  ============================================================ }

type
    TTrafficLight = (TL_RED, TL_YELLOW, TL_GREEN);

function GetAction(light: TTrafficLight): string;
begin
    case light of
        TL_RED: Result := 'Stop';
        TL_YELLOW: Result := 'Caution';
        TL_GREEN: Result := 'Go';
    end;
end;

function NextLight(light: TTrafficLight): TTrafficLight;
begin
    case light of
        TL_RED: Result := TL_GREEN;
        TL_YELLOW: Result := TL_RED;
        TL_GREEN: Result := TL_YELLOW;
    end;
end;

procedure DemonstrateStateMachine;
var
    light: TTrafficLight;
    i: Integer;
begin
    WriteLn;
    WriteLn('=== Traffic Light State Machine ===');
    
    light := TL_RED;
    for i := 1 to 4 do
    begin
        WriteLn('Light: ', Ord(light), ' - ', GetAction(light));
        light := NextLight(light);
    end;
end;

{ ============================================================
  ENUM TO STRING AND BACK
  ============================================================ }

type
    TLogLevel = (DEBUG, INFO, WARNING, ERROR, FATAL);

function LogLevelToString(level: TLogLevel): string;
begin
    case level of
        DEBUG: Result := 'DEBUG';
        INFO: Result := 'INFO';
        WARNING: Result := 'WARNING';
        ERROR: Result := 'ERROR';
        FATAL: Result := 'FATAL';
    end;
end;

function StringToLogLevel(const s: string): TLogLevel;
begin
    if s = 'DEBUG' then Result := DEBUG
    else if s = 'INFO' then Result := INFO
    else if s = 'WARNING' then Result := WARNING
    else if s = 'ERROR' then Result := ERROR
    else if s = 'FATAL' then Result := FATAL
    else Result := INFO;  { Default }
end;

procedure DemonstrateEnumConversion;
var
    level: TLogLevel;
    levelStr: string;
begin
    WriteLn;
    WriteLn('=== Enum Conversion ===');
    
    level := WARNING;
    levelStr := LogLevelToString(level);
    WriteLn('Level: ', levelStr);
    
    level := StringToLogLevel('ERROR');
    WriteLn('Converted from string: ', LogLevelToString(level));
end;

{ ============================================================
  MAIN PROGRAM
  ============================================================ }

begin
    WriteLn('=== Enums in Pascal ===');
    WriteLn;
    
    DemonstrateBasicEnum;
    DemonstrateHttpStatus;
    DemonstrateDaysOfWeek;
    DemonstrateEnumRanges;
    DemonstrateEnumSets;
    DemonstrateStateMachine;
    DemonstrateEnumConversion;
    
    WriteLn;
    WriteLn('💡 Pascal Enum Features:');
    WriteLn('   ✓ Type-safe enumerated types');
    WriteLn('   ✓ Automatic ordinal values (0, 1, 2, ...)');
    WriteLn('   ✓ Range checking and iteration');
    WriteLn('   ✓ Set operations for bitwise flags');
    WriteLn('   ✗ Cannot specify custom ordinal values directly');
    
    WriteLn;
    WriteLn('✓ Program completed successfully');
end.
