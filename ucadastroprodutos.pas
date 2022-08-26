unit uCadastroProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, Buttons, ZDataset;

type

  { TfCadastroProdutos }

  TfCadastroProdutos = class(TForm)
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnInserir: TSpeedButton;
    grdProdutos: TDBGrid;
    edtBuscar: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    qryProdutosChave: TZQuery;
    qryProdutosChaveADD: TLargeintField;
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure edtBuscarChange(Sender: TObject);
  private

  public

  end;

var
  fCadastroProdutos: TfCadastroProdutos;

implementation

uses uDataMobile, uEdicaoProdutos;

{$R *.lfm}

{ TfCadastroProdutos }

procedure TfCadastroProdutos.btnInserirClick(Sender: TObject);
begin
   DataModule1.qryProdutos.Filtered := False;
   qryProdutosChave.Close;
   qryProdutosChave.Open;
   DataModule1.qryProdutos.Insert;
   DataModule1.qryProdutosCHAVE.Value := qryProdutosChaveADD.Value;
   fEdicaoProdutos                    := TfEdicaoProdutos.Create(Self);
   fEdicaoProdutos.ShowModal;
end;

procedure TfCadastroProdutos.edtBuscarChange(Sender: TObject);
begin
   DataModule1.qryProdutos.Filter := 'DESCRICAO LIKE'+QuotedStr('*'+edtBuscar.Text+'*');
   DataModule1.qryProdutos.Filtered := True;
end;

procedure TfCadastroProdutos.btnEditarClick(Sender: TObject);
begin
   DataModule1.qryProdutos.Filtered := False;
   DataModule1.qryProdutos.Edit;
   fEdicaoProdutos := TfEdicaoProdutos.Create(Self);
   fEdicaoProdutos.ShowModal;
end;

procedure TfCadastroProdutos.btnExcluirClick(Sender: TObject);
begin
   DataModule1.qryProdutos.Delete;
   DataModule1.qryProdutos.ApplyUpdates;
end;

end.

