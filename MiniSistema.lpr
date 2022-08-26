program MiniSistema;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, uMenu, uDataMobile, uCadastroClientes, uEdicaoCliente, 
uCadastroProdutos, uEdicaoProdutos, uLancamentoVendas, uEdicaoItensVenda, 
uConsultasVendas, uContasAReceber, uRelatorioContasAReceber
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfMenu, fMenu);
  Application.Run;
end.

