unit uContasAReceber;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, Buttons, Menus, ZDataset, DateTimePicker;

type

  { TfContasAReceber }

  TfContasAReceber = class(TForm)
    btnBuscar: TSpeedButton;
    cbStatus: TComboBox;
    dsContasAReceber: TDataSource;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    lblStatus: TLabel;
    lblFiltrarVenda: TLabel;
    lblValorTotalListado: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    TContasAReceber: TZTable;
    TContasAReceberCHAVE: TLongintField;
    TContasAReceberCHAVE_CLIENTE: TLongintField;
    TContasAReceberCHAVE_VENDA: TLongintField;
    TContasAReceberDATA_PAGAMEMTO: TDateField;
    TContasAReceberDATA_VENCIMENTO: TDateField;
    TContasAReceberSTATUS: TStringField;
    TContasAReceberVALOR: TFloatField;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private

  public

  end;

var
  fContasAReceber: TfContasAReceber;

implementation

uses uDataMobile;

{$R *.lfm}

{ TfContasAReceber }

procedure TfContasAReceber.btnBuscarClick(Sender: TObject);
var
   dvalor_total: Double;
begin
   TContasAReceber.Open;
   TContasAReceber.Filter := 'DATA_VENCIMENTO >= '+QuotedStr(DateTimeToStr(DateTimePicker1.Date))+' AND DATA_VENCIMENTO <= '+QuotedStr(DateTimeToStr(DateTimePicker2.Date));
   if cbStatus.ItemIndex = 1 then
   begin
      TContasAReceber.Filter := TContasAReceber.Filter + 'AND STATUS = '+QuotedStr('PAGO');
   end
   else
      if cbStatus.ItemIndex = 2 then
   begin
      TContasAReceber.Filter := TContasAReceber.Filter + 'AND STATUS = '+QuotedStr('PENDENTE');
   end;
   TContasAReceber.Filtered  := True;

   dvalor_total := 0;
   TContasAReceber.First;
   while not(TContasAReceber.EOF) do
   begin
      dvalor_total := dvalor_total + TContasAReceberVALOR.Value;
      TContasAReceber.Next;
   end;

   lblValorTotalListado.Caption := 'Valor Total Listado: '+FormatFloat('R$###,###,##0.00',dvalor_total);
end;

procedure TfContasAReceber.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   TContasAReceber.Filtered := False;
end;

procedure TfContasAReceber.FormShow(Sender: TObject);
begin
   btnBuscar.Click;
end;

procedure TfContasAReceber.MenuItem1Click(Sender: TObject);
begin
   TContasAReceber.Edit;
   TContasAReceberSTATUS.Value := 'PAGO';
   TContasAReceber.Post;
   TContasAReceber.ApplyUpdates;

   DataModule1.qryContasReceber.Close;
   DataModule1.qryContasReceber.Open;
end;

procedure TfContasAReceber.MenuItem2Click(Sender: TObject);
begin
   TContasAReceber.Edit;
   TContasAReceberSTATUS.Value := 'PENDENTE';
   TContasAReceber.Post;
   TContasAReceber.ApplyUpdates;

   DataModule1.qryContasReceber.Close;
   DataModule1.qryContasReceber.Open;
end;

end.

