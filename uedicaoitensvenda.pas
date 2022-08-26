unit uEdicaoItensVenda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons;

type

  { TfEdicaoItensVenda }

  TfEdicaoItensVenda = class(TForm)
    edtPrecoUnitario: TDBEdit;
    edtValorTotal: TDBEdit;
    edtQuantidade: TDBEdit;
    lblValorTotal: TLabel;
    lblQuantidade: TLabel;
    lblPrecoUnitario: TLabel;
    lcbDescricaoProduto: TDBLookupComboBox;
    edtProduto: TDBEdit;
    lblProduto: TLabel;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure edtPrecoUnitarioExit(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure lcbDescricaoProdutoExit(Sender: TObject);
  private

  public

  end;

var
  fEdicaoItensVenda: TfEdicaoItensVenda;

implementation

uses uDataMobile;

{$R *.lfm}

{ TfEdicaoItensVenda }

procedure TfEdicaoItensVenda.btnCancelarClick(Sender: TObject);
begin
   btnCancelar.Enabled := False;
   DataModule1.qryItensVendas.Cancel;
   Close;
end;

procedure TfEdicaoItensVenda.btnSalvarClick(Sender: TObject);
begin
   btnCancelar.Enabled := False;
   DataModule1.qryItensVendas.Post;
   DataModule1.qryItensVendas.ApplyUpdates;
   Close;
end;

procedure TfEdicaoItensVenda.DBEdit1Exit(Sender: TObject);
begin

end;

procedure TfEdicaoItensVenda.edtPrecoUnitarioExit(Sender: TObject);
begin
   DataModule1.qryItensVendasVALOR_TOTAL.Value    := DataModule1.qryItensVendasPRECO_UNITARIO.Value * DataModule1.qryItensVendasQUANTIDADE.Value;
end;

procedure TfEdicaoItensVenda.edtProdutoExit(Sender: TObject);
begin
   if DataModule1.qryProdutos.Locate('CHAVE', DataModule1.qryItensVendasCHAVE_PRODUTO.Value, []) then
   begin
      DataModule1.qryProdutos.Locate('CHAVE', DataModule1.qryItensVendasCHAVE_PRODUTO.Value, []);
      DataModule1.qryItensVendasPRECO_UNITARIO.Value := DataModule1.qryProdutosPRECO_VENDA.Value;
      DataModule1.qryItensVendasVALOR_TOTAL.Value    := DataModule1.qryItensVendasPRECO_UNITARIO.Value * DataModule1.qryItensVendasQUANTIDADE.Value;
   end;
end;

procedure TfEdicaoItensVenda.edtQuantidadeExit(Sender: TObject);
begin
   DataModule1.qryItensVendasVALOR_TOTAL.Value    := DataModule1.qryItensVendasPRECO_UNITARIO.Value * DataModule1.qryItensVendasQUANTIDADE.Value;
end;

procedure TfEdicaoItensVenda.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   if btnCancelar.Enabled = True then
   begin
      DataModule1.qryItensVendas.Cancel;
   end;
end;

procedure TfEdicaoItensVenda.lcbDescricaoProdutoExit(Sender: TObject);
begin
   if DataModule1.qryProdutos.Locate('CHAVE', DataModule1.qryItensVendasCHAVE_PRODUTO.Value, []) then
   begin
      DataModule1.qryProdutos.Locate('CHAVE', DataModule1.qryItensVendasCHAVE_PRODUTO.Value, []);
      DataModule1.qryItensVendasPRECO_UNITARIO.Value := DataModule1.qryProdutosPRECO_VENDA.Value;
      DataModule1.qryItensVendasVALOR_TOTAL.Value    := DataModule1.qryItensVendasPRECO_UNITARIO.Value * DataModule1.qryItensVendasQUANTIDADE.Value;
   end;
end;

end.

