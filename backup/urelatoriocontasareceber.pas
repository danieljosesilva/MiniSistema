unit uRelatorioContasAReceber;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ZDataset, RLReport,
  RLPDFFilter;

type

  { TfRelatorioContasAReceber }

  TfRelatorioContasAReceber = class(TForm)
    dsRelatorio: TDataSource;
    qryRelatorioCHAVE: TLongintField;
    qryRelatorioCHAVE_CLIENTE: TLongintField;
    qryRelatorioCHAVE_VENDA: TLongintField;
    qryRelatorioDATA_PAGAMEMTO: TDateField;
    qryRelatorioDATA_VENCIMENTO: TDateField;
    qryRelatorioSTATUS: TStringField;
    qryRelatorioVALOR: TFloatField;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    lblTotalRelatorio: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    RLReport1: TRLReport;
    qryRelatorio: TZQuery;
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private

  public

  end;

var
  fRelatorioContasAReceber: TfRelatorioContasAReceber;
  dvalor_total: Double;

implementation

uses uContasAReceber, uDataMobile;

{$R *.lfm}

{ TfRelatorioContasAReceber }

procedure TfRelatorioContasAReceber.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
   dvalor_total := 0;
end;

procedure TfRelatorioContasAReceber.RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
   dvalor_total := dvalor_total + qryRelatorioVALOR.Value;
end;

procedure TfRelatorioContasAReceber.RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
   lblTotalRelatorio.Caption := FormatFloat('R$###.###.##0,00', dvalor_total);
end;

end.

