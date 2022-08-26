unit uEdicaoProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  DBCtrls;

type

  { TfEdicaoProdutos }

  TfEdicaoProdutos = class(TForm)
    btnCancelar: TSpeedButton;
    btnSalvar: TSpeedButton;
    cbUnidade: TDBComboBox;
    mObservacao: TDBMemo;
    edtChave: TDBEdit;
    edtCodBarras: TDBEdit;
    edtDescricao: TDBEdit;
    edtEstoque: TDBEdit;
    edtPrecoCompra: TDBEdit;
    edtPrecoVenda: TDBEdit;
    Label1: TLabel;
    lblUnidade: TLabel;
    lblChave: TLabel;
    lblCodBarras: TLabel;
    lblDescricao: TLabel;
    lblEstoque: TLabel;
    lblPrecoCompra: TLabel;
    lblEstoque2: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  fEdicaoProdutos: TfEdicaoProdutos;

implementation

uses uDataMobile;

{$R *.lfm}

{ TfEdicaoProdutos }

procedure TfEdicaoProdutos.btnSalvarClick(Sender: TObject);
begin
   DataModule1.qryProdutos.Post;
   DataModule1.qryProdutos.ApplyUpdates;
   btnCancelar.Enabled := false;
   Close;
end;

procedure TfEdicaoProdutos.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   if btnCancelar.Enabled then
   begin
      DataModule1.qryProdutos.Cancel;
   end;
end;

procedure TfEdicaoProdutos.btnCancelarClick(Sender: TObject);
begin
   DataModule1.qryProdutos.Cancel;
   btnCancelar.Enabled := false;
   Close;
end;

end.

