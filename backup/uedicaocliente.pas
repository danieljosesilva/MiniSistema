unit uEdicaoCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  DBCtrls;

type

  { TfEdicaoCliente }

  TfEdicaoCliente = class(TForm)
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    cbUF: TDBComboBox;
    edtChave: TDBEdit;
    lblChave: TLabel;
    mObservacao: TDBMemo;
    edtSexo: TDBComboBox;
    DBRadioGroup1: TDBRadioGroup;
    edtNome: TDBEdit;
    edtCidade: TDBEdit;
    edtTelefone: TDBEdit;
    edtTelefone2: TDBEdit;
    edtEmail: TDBEdit;
    edtCPFCNPJ: TDBEdit;
    edtRGIE: TDBEdit;
    edtCep: TDBEdit;
    edtLogradouro: TDBEdit;
    edtNumero: TDBEdit;
    edtComplemento: TDBEdit;
    edtBairro: TDBEdit;
    lblSexo: TLabel;
    lblNome: TLabel;
    lblCidade: TLabel;
    lblUF: TLabel;
    lblTelefone: TLabel;
    lblTelefone2: TLabel;
    lblEmail: TLabel;
    lblObservacao: TLabel;
    lblCPFCNPJ: TLabel;
    lblRGIE: TLabel;
    lblCep: TLabel;
    lblLogradouro: TLabel;
    lblNumero: TLabel;
    lblComplemento: TLabel;
    lblBairro: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private

  public

  end;

var
  fEdicaoCliente: TfEdicaoCliente;

implementation

uses uDataMobile, uCadastroClientes;

{$R *.lfm}

{ TfEdicaoCliente }

procedure TfEdicaoCliente.btnSalvarClick(Sender: TObject);
begin
   DataModule1.qryCliente.Post;
   DataModule1.qryCliente.ApplyUpdates;
   Close;
end;

procedure TfEdicaoCliente.btnCancelarClick(Sender: TObject);
begin
   DataModule1.qryCliente.Cancel;
   Close;
end;

end.

