unit uLancamentoVendas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Buttons, DBGrids, StdCtrls, DBCtrls, ZDataset;

type

  { TfLancamentoVendas }

  TfLancamentoVendas = class(TForm)
    DBGrid2: TDBGrid;
    edtVencimento: TDBComboBox;
    edtQTDParcelas: TDBEdit;
    edtPagoEntrada: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    edtData: TDBEdit;
    edtCliente: TDBEdit;
    edtValorTotal: TDBEdit;
    edtNumeroVenda: TDBEdit;
    DBGrid1: TDBGrid;
    edtId: TDBText;
    edtHorario: TDBEdit;
    lblVencimento: TLabel;
    lblQTDParcelas: TLabel;
    lblPagoEntrada: TLabel;
    lblValorTotal: TLabel;
    lblCliente: TLabel;
    lblHorario: TLabel;
    lblId: TLabel;
    lblNumeroVenda: TLabel;
    lblData: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnInserirItem: TSpeedButton;
    btnEditarItem: TSpeedButton;
    Panel5: TPanel;
    btnGerarParcelas: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    qrySomaItensSUM: TFloatField;
    qryVendasChaveADD: TLargeintField;
    qryVendasChaveCReceberADD: TLargeintField;
    btnExcluir: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    qryVendasChaveCReceber: TZQuery;
    qryVendasChave: TZQuery;
    qrySomaItens: TZQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGerarParcelasClick(Sender: TObject);
    procedure btnInserirItemClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  fLancamentoVendas: TfLancamentoVendas;
  binserindo_novo_item: Boolean;

implementation

uses uDataMobile, uEdicaoItensVenda;

{$R *.lfm}

{ TfLancamentoVendas }

procedure TfLancamentoVendas.btnInserirItemClick(Sender: TObject);
begin
   binserindo_novo_item := True;
   qryVendasChave.Close;
   qryVendasChave.Open;
   DataModule1.qryItensVendas.Insert;
   DataModule1.qryItensVendasCHAVE.Value       := qryVendasChaveADD.Value;
   DataModule1.qryItensVendasCHAVE_VENDA.Value := DataModule1.qryVendasCHAVE.Value;
   fEdicaoItensVenda := TfEdicaoItensVenda.Create(Self);
   fEdicaoItensVenda.ShowModal;

   qrySomaItens.Close;
   qrySomaItens.ParamByName('chavevenda').Value := DataModule1.qryVendasCHAVE.Value;
   qrySomaItens.Open;
   DataModule1.qryVendasVALOR_TOTAL.Value       := qrySomaItensSUM.Value;
end;

procedure TfLancamentoVendas.btnSalvarClick(Sender: TObject);
begin
   btnCancelar.Enabled := False;

   //baixa do estoque
   DataModule1.qryItensVendas.First;
   while not(DataModule1.qryItensVendas.EOF) do
   begin
     if DataModule1.qryProdutos.Locate('CHAVE', DataModule1.qryItensVendasCHAVE_PRODUTO.Value,[])then
     begin
        DataModule1.qryProdutos.Locate('CHAVE', DataModule1.qryItensVendasCHAVE_PRODUTO.Value,[]);
        DataModule1.qryProdutos.Edit;
        DataModule1.qryProdutosESTOQUE.Value := DataModule1.qryProdutosESTOQUE.Value - DataModule1.qryItensVendasQUANTIDADE.Value;
        DataModule1.qryProdutos.Post;
        DataModule1.qryProdutos.ApplyUpdates;
     end;
     DataModule1.qryItensVendas.Next;
   end;

   DataModule1.qryVendas.Post;
   DataModule1.qryVendas.ApplyUpdates;
   Close;
end;

procedure TfLancamentoVendas.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   if btnCancelar.Enabled = False then
   begin
     DataModule1.qryVendas.Cancel;
   end;
end;

procedure TfLancamentoVendas.btnEditarItemClick(Sender: TObject);
begin
   binserindo_novo_item := False;
   DataModule1.qryItensVendas.Edit;
   fEdicaoItensVenda    := TfEdicaoItensVenda.Create(Self);
   fEdicaoItensVenda.ShowModal;

   qrySomaItens.Close;
   qrySomaItens.ParamByName('chavevenda').Value := DataModule1.qryVendasCHAVE.Value;
   qrySomaItens.Open;
   DataModule1.qryVendasVALOR_TOTAL.Value       := qrySomaItensSUM.Value;
end;

procedure TfLancamentoVendas.btnCancelarClick(Sender: TObject);
begin
   btnCancelar.Enabled := False;
   DataModule1.qryVendas.Cancel;
   Close;
end;

procedure TfLancamentoVendas.btnExcluirClick(Sender: TObject);
begin
   DataModule1.qryItensVendas.Delete;
   DataModule1.qryItensVendas.ApplyUpdates;

   qrySomaItens.Close;
   qrySomaItens.ParamByName('chavevenda').Value := DataModule1.qryVendasCHAVE.Value;
   qrySomaItens.Open;
   DataModule1.qryVendasVALOR_TOTAL.Value       := qrySomaItensSUM.Value;
end;

procedure TfLancamentoVendas.btnGerarParcelasClick(Sender: TObject);
var
   dvalor_parcela: Double;
   iparcelas_lancadas, imes, iano: Integer;
   sdata_vencimento: String;
begin
   DataModule1.qryContasReceber.First;
   while not(DataModule1.qryContasReceber.EOF) do
   begin
     DataModule1.qryContasReceber.Delete;
     DataModule1.qryContasReceber.ApplyUpdates;
   end;

   if DataModule1.qryVendasQUANTIDADE_PARCELAS.Value > 0 then
   begin
      dvalor_parcela := (DataModule1.qryVendasVALOR_TOTAL.Value - DataModule1.qryVendasVALOR_PAGO_ENTRADA.Value) / DataModule1.qryVendasQUANTIDADE_PARCELAS.Value;
   end;

   if DataModule1.qryVendasVALOR_PAGO_ENTRADA.Value > 0 then
   begin
      qryVendasChaveCReceber.Close;
      qryVendasChaveCReceber.Open;
      DataModule1.qryContasReceber.Insert;
      DataModule1.qryContasReceberCHAVE.Value := qryVendasChaveCReceberADD.Value;
      DataModule1.qryContasReceberCHAVE_CLIENTE.Value   := DataModule1.qryVendasCLIENTE.Value;
      DataModule1.qryContasReceberCHAVE_VENDA.Value     := DataModule1.qryVendasCHAVE.Value;
      DataModule1.qryContasReceberDATA_PAGAMEMTO.Value  := DataModule1.qryVendasDATA.Value;
      DataModule1.qryContasReceberDATA_VENCIMENTO.Value := StrToDateTime(sdata_vencimento);
      DataModule1.qryContasReceberSTATUS.Value          := 'PAGO';
      DataModule1.qryContasReceberVALOR.Value           := dvalor_parcela;
      DataModule1.qryContasReceber.Post;
      DataModule1.qryContasReceber.ApplyUpdates;
   end;

   imes := StrToInt(FormatDateTime('MM', DataModule1.qryVendasDATA.Value));
   iano := StrToInt(FormatDateTime('YYYY', DataModule1.qryVendasDATA.Value));
   iparcelas_lancadas := 0;
   while(iparcelas_lancadas > DataModule1.qryVendasQUANTIDADE_PARCELAS.Value) do
   begin
     if imes = 12 then
     begin
        imes := 1;
        iano := iano + 1;
     end
     else
     begin
        imes := imes + 1;
     end;
     sdata_vencimento := DataModule1.qryVendasDIA_DO_MES_PRA_VENCER.AsString+'/'+IntToStr(imes)+'/'+IntToStr(iano);

      qryVendasChaveCReceber.Close;
      qryVendasChaveCReceber.Open;
      DataModule1.qryContasReceber.Insert;
      DataModule1.qryContasReceberCHAVE.Value := qryVendasChaveCReceberADD.Value;
      DataModule1.qryContasReceberCHAVE_CLIENTE.Value   := DataModule1.qryVendasCLIENTE.Value;
      DataModule1.qryContasReceberCHAVE_VENDA.Value     := DataModule1.qryVendasCHAVE.Value;
      DataModule1.qryContasReceberDATA_VENCIMENTO.Value := DataModule1.qryVendasDATA.Value;
      DataModule1.qryContasReceberSTATUS.Value          := 'PENDENTE';
      DataModule1.qryContasReceberVALOR.Value           := DataModule1.qryVendasVALOR_PAGO_ENTRADA.Value;
      DataModule1.qryContasReceber.Post;
      DataModule1.qryContasReceber.ApplyUpdates;

      iparcelas_lancadas := iparcelas_lancadas + 1;
     end;
   end;
end.

