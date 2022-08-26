unit uMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  Buttons, ZDataset;

type

  { TfMenu }

  TfMenu = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Panel1: TPanel;
    btnCadastroClientes: TSpeedButton;
    btnCadastroProdutos: TSpeedButton;
    qryUltimaChaveVenda: TZQuery;
    qryUltimaChaveVendaADD: TLargeintField;
    btnLancamentoVenda: TSpeedButton;
    btnConsultaVendas: TSpeedButton;
    btnContasAReceber: TSpeedButton;
    procedure btnCadastroClientesClick(Sender: TObject);
    procedure btnCadastroProdutosClick(Sender: TObject);
    procedure btnConsultaVendasClick(Sender: TObject);
    procedure btnContasAReceberClick(Sender: TObject);
    procedure btnLancamentoVendaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private

  public

  end;

var
  fMenu: TfMenu;

implementation

uses uCadastroClientes, uDataMobile, uCadastroProdutos, uLancamentoVendas, uConsultasVendas, uContasAReceber;

{$R *.lfm}

{ TfMenu }

procedure TfMenu.MenuItem2Click(Sender: TObject);
begin
   fCadastroClientes := TfCadastroClientes.Create(Self);
   fCadastroClientes.ShowModal;
end;

procedure TfMenu.MenuItem3Click(Sender: TObject);
begin
  fCadastroProdutos := TfCadastroProdutos.Create(Self);
  fCadastroProdutos.ShowModal;
end;

procedure TfMenu.btnCadastroClientesClick(Sender: TObject);
begin
   fCadastroClientes := TfCadastroClientes.Create(Self);
   fCadastroClientes.ShowModal;
end;

procedure TfMenu.btnCadastroProdutosClick(Sender: TObject);
begin
   fCadastroProdutos := TfCadastroProdutos.Create(Self);
   fCadastroProdutos.ShowModal;
end;

procedure TfMenu.btnConsultaVendasClick(Sender: TObject);
begin
   fConsultasVendas := TfConsultasVendas.Create(Self);
   fConsultasVendas.ShowModal;
end;

procedure TfMenu.btnContasAReceberClick(Sender: TObject);
begin
   fContasAReceber := TfContasAReceber.Create(Self);
   fContasAReceber.ShowModal;
end;

procedure TfMenu.btnLancamentoVendaClick(Sender: TObject);
begin
   qryUltimaChaveVenda.Close;
   qryUltimaChaveVenda.Open;
   DataModule1.qryVendas.Insert;
   DataModule1.qryVendasCHAVE.Value   := qryUltimaChaveVendaADD.Value;
   DataModule1.qryVendasDATA.Value    := Date;
   DataModule1.qryVendasHORARIO.Value := Time;
   DataModule1.qryVendasNUMERO.Value  := qryUltimaChaveVendaADD.Value;

   DataModule1.qryVendas.Close;
   DataModule1.qryVendas.Open;

   DataModule1.qryContasReceber.Close;
   DataModule1.qryContasReceber.Open;

   fLancamentoVendas                  := TfLancamentoVendas.Create(Self);
   fLancamentoVendas.ShowModal;
end;

procedure TfMenu.FormCreate(Sender: TObject);
begin
   DataModule1 := TDataModule1.Create(Self);
   DataModule1.qryCliente.Open;
   DataModule1.qryProdutos.Open;
   DataModule1.qryVendas.Open;
   DataModule1.qryItensVendas.Open;
   DataModule1.qryContasReceber.Open;
end;

end.

