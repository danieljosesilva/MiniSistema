unit uCadastroClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, Buttons, ZDataset;

type

  { TfCadastroClientes }

  TfCadastroClientes = class(TForm)
    DBGrid1: TDBGrid;
    edtBuscar: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    btnInserir: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    qryClienteChave: TZQuery;
    qryClienteChaveADD: TLargeintField;
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure edtBuscarChange(Sender: TObject);
  private

  public

  end;

var
  fCadastroClientes: TfCadastroClientes;

implementation

uses uDataMobile, uEdicaoCliente;

{$R *.lfm}

{ TfCadastroClientes }

procedure TfCadastroClientes.btnInserirClick(Sender: TObject);
begin
   DataModule1.qryCliente.Filtered := False;
   qryClienteChave.Close;
   qryClienteChave.Open;
   DataModule1.qryCliente.Insert;
   DataModule1.qryClienteCHAVE.Value := qryClienteChaveADD.Value;
   fEdicaoCliente                    := TfEdicaoCliente.Create(Self);
   fEdicaoCliente.ShowModal;
end;

procedure TfCadastroClientes.edtBuscarChange(Sender: TObject);
begin
   DataModule1.qryCliente.Filter := 'Nome LIKE'+QuotedStr('*'+edtBuscar.Text+'*');
   DataModule1.qryCliente.Filtered := True;
end;

procedure TfCadastroClientes.btnEditarClick(Sender: TObject);
begin
   DataModule1.qryCliente.Filtered := False;
   DataModule1.qryCliente.Edit;
   fEdicaoCliente := TfEdicaoCliente.Create(Self);
   fEdicaoCliente.ShowModal;
end;

procedure TfCadastroClientes.btnExcluirClick(Sender: TObject);
begin
   DataModule1.qryCliente.Delete;
   DataModule1.qryCliente.ApplyUpdates;
end;

end.

