{******************************************************************************}
{                                                                              }
{                                  Delphereum                                  }
{                                                                              }
{             Copyright(c) 2018 Stefan van As <svanas@runbox.com>              }
{           Github Repository <https://github.com/svanas/delphereum>           }
{                                                                              }
{             Distributed under GNU AGPL v3.0 with Commons Clause              }
{                                                                              }
{   This program is free software: you can redistribute it and/or modify       }
{   it under the terms of the GNU Affero General Public License as published   }
{   by the Free Software Foundation, either version 3 of the License, or       }
{   (at your option) any later version.                                        }
{                                                                              }
{   This program is distributed in the hope that it will be useful,            }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of             }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              }
{   GNU Affero General Public License for more details.                        }
{                                                                              }
{   You should have received a copy of the GNU Affero General Public License   }
{   along with this program.  If not, see <https://www.gnu.org/licenses/>      }
{                                                                              }
{******************************************************************************}
// Delphereum Study. Tutorial 'Delphi and the Ethereum Dark Forest'
// Project in Embarcadero Delphi 11 made with source of this tutorial: https://svanas.medium.com/delphi-and-the-ethereum-dark-forest-5b430da3ad93
// Prepared by Valient Newman <valient.newman@proton.me>
// My Github Repository <https://github.com/valient-newman>

unit DelphiAndEthereumDarkForestUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs,
   // Delphi
  System.Classes,
  System.JSON,
  System.UITypes,
  // FireMonkey
{  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Memo,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.Types,}
  // web3
  web3,
  web3.eth.blocknative.mempool,
  web3.eth.blocknative.mempool.sgc, Vcl.Controls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Mempool: IMempool;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Mempool := TSgcMempool.Subscribe(
    Ethereum,                                     // ethereum main net
    TProxy.Disabled,                              // no proxy server
    'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',       // your blocknative API key
    '0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48', // address to watch
    procedure(event: TJsonObject; err: IError)    // continuous events (or a blocknative error)
    begin
      var tx := web3.eth.blocknative.mempool.getTransaction(event);
      if Assigned(tx) then
        TThread.Synchronize(nil, procedure
        begin
          Memo1.Lines.Add(tx.ToString);
        end);
    end,
    procedure(err: IError) // non-blocknative-error handler (probably a socket error)
    begin
      TThread.Synchronize(nil, procedure
      begin
        MessageDlg(err.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
      end);
    end,
    procedure
    begin
      // connection closed
    end);
end;

end.
