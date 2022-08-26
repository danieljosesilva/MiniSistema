unit uDataMobile;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset, ZSequence, ZGroupedConnection;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    dsVendas: TDataSource;
    dsItensVendas: TDataSource;
    dsContasReceber: TDataSource;
    dsProdutos: TDataSource;
    dsCliente: TDataSource;
    qryCliente: TZTable;
    qryClienteBAIRRO: TStringField;
    qryClienteCEP: TStringField;
    qryClienteCHAVE: TLongintField;
    qryClienteCIDADE: TStringField;
    qryClienteCOMPLEMENTO: TStringField;
    qryClienteCPF_CNPJ: TStringField;
    qryClienteEMAIL: TStringField;
    qryClienteLOGRADOURO: TStringField;
    qryClienteNOME: TStringField;
    qryClienteNUMERO: TStringField;
    qryClienteOBSERVACAO: TStringField;
    qryClienteRG_IE: TStringField;
    qryClienteSEXO: TStringField;
    qryClienteTELEFONE_1: TStringField;
    qryClienteTELEFONE_2: TStringField;
    qryClienteTIPO_PESSOA: TStringField;
    qryClienteUF: TStringField;
    qryContasReceberCHAVE: TLongintField;
    qryContasReceberCHAVE_CLIENTE: TLongintField;
    qryContasReceberCHAVE_VENDA: TLongintField;
    qryContasReceberDATA_PAGAMEMTO: TDateField;
    qryContasReceberDATA_VENCIMENTO: TDateField;
    qryContasReceberSTATUS: TStringField;
    qryContasReceberVALOR: TFloatField;
    qryItensVendasCHAVE: TLongintField;
    qryItensVendasCHAVE_PRODUTO: TLongintField;
    qryItensVendasCHAVE_VENDA: TLongintField;
    qryItensVendasPRECO_UNITARIO: TFloatField;
    qryItensVendasQUANTIDADE: TFloatField;
    qryItensVendasVALOR_TOTAL: TFloatField;
    qryProdutosCHAVE: TLongintField;
    qryProdutosCODIGOBARRAS: TStringField;
    qryProdutosDESCRICAO: TStringField;
    qryProdutosESTOQUE: TFloatField;
    qryProdutosOBSERVACAO: TStringField;
    qryProdutosPRECO_COMPRA: TFloatField;
    qryProdutosPRECO_VENDA: TFloatField;
    qryProdutosUNIDADE: TStringField;
    qryVendasCHAVE: TLongintField;
    qryVendasCLIENTE: TLongintField;
    qryVendasDATA: TDateField;
    qryVendasDIA_DO_MES_PRA_VENCER: TLongintField;
    qryVendasHORARIO: TTimeField;
    qryVendasNUMERO: TLongintField;
    qryVendasQUANTIDADE_PARCELAS: TLongintField;
    qryVendasVALOR_PAGO_ENTRADA: TFloatField;
    qryVendasVALOR_TOTAL: TFloatField;
    ZConnection1: TZConnection;
    qryProdutos: TZTable;
    qryVendas: TZTable;
    qryItensVendas: TZTable;
    qryContasReceber: TZTable;
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

end.

