{ Bank Account System in Object Pascal
  Demonstrates full OOP: classes, inheritance, polymorphism, encapsulation }

program BankAccountSystem;

{$mode objfpc}{$H+}

uses
  SysUtils;

{ ============================================================
  BASE ACCOUNT CLASS
  ============================================================ }

type
  TAccount = class
  protected
    FAccountNumber: string;
    FOwnerName: string;
    FBalance: Real;
  public
    constructor Create(const AAccountNumber, AOwnerName: string; AInitialBalance: Real);
    destructor Destroy; override;
    
    procedure Deposit(Amount: Real); virtual;
    procedure Withdraw(Amount: Real); virtual; abstract;  { Abstract method }
    procedure Display; virtual;
    
    { Properties (encapsulation) }
    property AccountNumber: string read FAccountNumber;
    property OwnerName: string read FOwnerName;
    property Balance: Real read FBalance;
    
    function GetAccountType: string; virtual; abstract;
  end;

{ Account Implementation }

constructor TAccount.Create(const AAccountNumber, AOwnerName: string; AInitialBalance: Real);
begin
  inherited Create;
  FAccountNumber := AAccountNumber;
  FOwnerName := AOwnerName;
  FBalance := AInitialBalance;
  WriteLn('✓ Account created: ', AAccountNumber, ' for ', AOwnerName);
end;

destructor TAccount.Destroy;
begin
  WriteLn('✓ Account destroyed: ', FAccountNumber);
  inherited Destroy;
end;

procedure TAccount.Deposit(Amount: Real);
begin
  if Amount > 0 then
  begin
    FBalance := FBalance + Amount;
    WriteLn(Format('✓ Deposited $%.2f. New balance: $%.2f', [Amount, FBalance]));
  end
  else
    WriteLn('❌ Invalid deposit amount');
end;

procedure TAccount.Display;
begin
  WriteLn;
  WriteLn('=== Account Details ===');
  WriteLn('Account Number: ', FAccountNumber);
  WriteLn('Owner: ', FOwnerName);
  WriteLn(Format('Balance: $%.2f', [FBalance]));
end;

{ ============================================================
  SAVINGS ACCOUNT CLASS (Inheritance)
  ============================================================ }

type
  TSavingsAccount = class(TAccount)
  private
    FInterestRate: Real;
  public
    constructor Create(const AAccountNumber, AOwnerName: string; 
                      AInitialBalance, AInterestRate: Real);
    
    procedure Withdraw(Amount: Real); override;
    procedure Display; override;
    procedure ApplyInterest;
    
    property InterestRate: Real read FInterestRate;
    function GetAccountType: string; override;
  end;

{ Savings Account Implementation }

constructor TSavingsAccount.Create(const AAccountNumber, AOwnerName: string; 
                                   AInitialBalance, AInterestRate: Real);
begin
  inherited Create(AAccountNumber, AOwnerName, AInitialBalance);
  FInterestRate := AInterestRate;
  WriteLn(Format('✓ Savings Account created with %.2f%% interest', [FInterestRate * 100]));
end;

procedure TSavingsAccount.Withdraw(Amount: Real);
begin
  WriteLn('🏦 [Savings Account] Processing withdrawal...');
  
  if (Amount > 0) and (Amount <= FBalance) then
  begin
    FBalance := FBalance - Amount;
    WriteLn(Format('✓ Withdrew $%.2f. New balance: $%.2f', [Amount, FBalance]));
  end
  else
    WriteLn('❌ Insufficient funds or invalid amount');
end;

procedure TSavingsAccount.ApplyInterest;
var
  Interest: Real;
begin
  Interest := FBalance * FInterestRate;
  FBalance := FBalance + Interest;
  WriteLn(Format('✓ Interest applied: $%.2f (rate: %.2f%%)', [Interest, FInterestRate * 100]));
end;

procedure TSavingsAccount.Display;
begin
  WriteLn;
  WriteLn('=== Savings Account Details ===');
  WriteLn('Account Number: ', FAccountNumber);
  WriteLn('Owner: ', FOwnerName);
  WriteLn(Format('Balance: $%.2f', [FBalance]));
  WriteLn(Format('Interest Rate: %.2f%%', [FInterestRate * 100]));
end;

function TSavingsAccount.GetAccountType: string;
begin
  Result := 'Savings';
end;

{ ============================================================
  CHECKING ACCOUNT CLASS (Inheritance)
  ============================================================ }

type
  TCheckingAccount = class(TAccount)
  private
    FOverdraftLimit: Real;
  public
    constructor Create(const AAccountNumber, AOwnerName: string;
                      AInitialBalance, AOverdraftLimit: Real);
    
    procedure Withdraw(Amount: Real); override;
    procedure Display; override;
    
    property OverdraftLimit: Real read FOverdraftLimit;
    function GetAccountType: string; override;
  end;

{ Checking Account Implementation }

constructor TCheckingAccount.Create(const AAccountNumber, AOwnerName: string;
                                    AInitialBalance, AOverdraftLimit: Real);
begin
  inherited Create(AAccountNumber, AOwnerName, AInitialBalance);
  FOverdraftLimit := AOverdraftLimit;
  WriteLn(Format('✓ Checking Account created with $%.2f overdraft', [FOverdraftLimit]));
end;

procedure TCheckingAccount.Withdraw(Amount: Real);
var
  AvailableBalance: Real;
begin
  AvailableBalance := FBalance + FOverdraftLimit;
  
  WriteLn('🏦 [Checking Account] Processing withdrawal...');
  
  if (Amount > 0) and (Amount <= AvailableBalance) then
  begin
    FBalance := FBalance - Amount;
    WriteLn(Format('✓ Withdrew $%.2f. New balance: $%.2f', [Amount, FBalance]));
    
    if FBalance < 0 then
      WriteLn(Format('⚠️  Overdraft used: $%.2f', [-FBalance]));
  end
  else
    WriteLn('❌ Exceeds overdraft limit');
end;

procedure TCheckingAccount.Display;
begin
  WriteLn;
  WriteLn('=== Checking Account Details ===');
  WriteLn('Account Number: ', FAccountNumber);
  WriteLn('Owner: ', FOwnerName);
  WriteLn(Format('Balance: $%.2f', [FBalance]));
  WriteLn(Format('Overdraft Limit: $%.2f', [FOverdraftLimit]));
end;

function TCheckingAccount.GetAccountType: string;
begin
  Result := 'Checking';
end;

{ ============================================================
  MAIN PROGRAM - DEMONSTRATION
  ============================================================ }

var
  Savings: TSavingsAccount;
  Checking: TCheckingAccount;
  Accounts: array[0..1] of TAccount;
  I: Integer;

begin
  WriteLn('=== Bank Account System (Object Pascal OOP) ===');
  WriteLn;
  
  { Create accounts }
  Savings := TSavingsAccount.Create('SAV001', 'Alice Johnson', 5000.0, 0.03);
  Checking := TCheckingAccount.Create('CHK001', 'Bob Smith', 1000.0, 500.0);
  
  try
    WriteLn;
    WriteLn('--- Savings Account Operations ---');
    Savings.Deposit(500.0);
    Savings.ApplyInterest;
    Savings.Display;
    
    WriteLn;
    WriteLn('--- Checking Account Operations ---');
    Checking.Withdraw(1200.0);  { Uses overdraft }
    Checking.Deposit(300.0);
    Checking.Display;
    
    { Polymorphism demonstration }
    WriteLn;
    WriteLn('--- Polymorphism Demo ---');
    Accounts[0] := Savings;
    Accounts[1] := Checking;
    
    for I := 0 to 1 do
    begin
      WriteLn;
      WriteLn('Account Type: ', Accounts[I].GetAccountType);
      Accounts[I].Display;
    end;
    
    WriteLn;
    WriteLn('✓ Program completed successfully');
    
  finally
    { Cleanup }
    Checking.Free;
    Savings.Free;
  end;
  
  ReadLn;  { Pause before exit }
end.
