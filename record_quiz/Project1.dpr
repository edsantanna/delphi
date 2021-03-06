program Project1;

{$APPTYPE CONSOLE}

uses
  System.Generics.Collections;

type
  TBar = record
    FBaz: Boolean;
    constructor Create(const iBaz: Boolean);
    procedure SetBaz(const iBaz: Boolean);
  end;

  TFoo = class
    FBars: TList<TBar>;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

{ TBar }

constructor TBar.Create(const iBaz: Boolean);
begin
  SetBaz(iBaz);
end;

procedure TBar.SetBaz(const iBaz: Boolean);
begin
  FBaz := iBaz;
end;

{ TFoo }

constructor TFoo.Create;
var
  Bar: TBar;
begin
  inherited;

  FBars := TList<TBar>.Create;

  // FBaz = False で生成
  FBars.Add(TBar.Create(False));

  // ローカル変数 Bar の FBaz が設定されただけで
  // FBars[0] の Bar が設定されるわけではない！
  for Bar in FBars do
    Bar.SetBaz(True);
end;

destructor TFoo.Destroy;
begin
  FBars.Free;

  inherited;
end;

begin
  with TFoo.Create do
    try
      if (FBars[0].FBaz) then
        Writeln('TRUE')
      else
        Writeln('FALSE');

      Readln;
    finally
      Free;
    end;
end.
