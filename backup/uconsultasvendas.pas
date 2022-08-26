unit uConsultasVendas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, DateTimePicker;

type

  { TfConsultasVendas }

  TfConsultasVendas = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    lblValorTotalListado: TLabel;
    lblFiltrarVenda: TLabel;
    Panel1: TPanel;
    btnBuscar: TSpeedButton;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fConsultasVendas: TfConsultasVendas;

implementation

uses uDataMobile;

{$R *.lfm}

{ TfConsultasVendas }

procedure TfConsultasVendas.btnBuscarClick(Sender: TObject);
var
   dvalor_total_listado: Double;
begin
   DataModule1.qryVendas.Filter   := 'DATA >= '+QuotedStr(DateTimeToStr(DateTimePicker1.Date))+' AND DATA <= '+QuotedStr(DateTimeToStr(DateTimePicker2.Date));
   DataModule1.qryVendas.Filtered := True;

   dvalor_total_listado := 0;
   DataModule1.qryVendas.First;
   while not(DataModule1.qryVendas.EOF) do
   begin
      dvalor_total_listado := dvalor_total_listado + DataModule1.qryVendasVALOR_TOTAL.Value;
      DataModule1.qryVendas.Next;
   end;
   lblValorTotalListado.Caption := 'Valor Total Listado: '+ FormatFloat('R$###,###,##0.00', dvalor_total_listado);
end;

procedure TfConsultasVendas.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   DataModule1.qryVendas.Filtered := False;
end;

procedure TfConsultasVendas.FormShow(Sender: TObject);
begin
  btnBuscar.Click;
end;

end.

