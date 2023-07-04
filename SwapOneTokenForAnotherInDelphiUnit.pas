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
// Delphereum Study. Tutorial 'Swap one token for another in Delphi'
// Project in Embarcadero Delphi 11 made with source of this tutorial: https://svanas.medium.com/swap-one-token-for-another-in-delphi-bcb999c47f7
// Prepared by Valient Newman <valient.newman@proton.me>
// My Github Repository <https://github.com/valient-newman>

unit SwapOneTokenForAnotherInDelphiUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
  web3, web3.eth, web3.eth.types, web3.eth.utils, web3.eth.infura, web3.eth.balancer.v2, Velthuis.BigIntegers;

procedure TForm1.Button1Click(Sender: TObject);
begin
// var INFURA_PROJECT_ID : string := 'https://mainnet.infura.io/v3/your-project-id';
const client: IWeb3 = TWeb3.Create(
  web3.eth.infura.endpoint(web3.Ethereum, 'https://mainnet.infura.io/v3/your-project-id').Value
);

const task = web3.eth.balancer.v2.listen(
  client,
  procedure(
    blockNo  : BigInteger;
    poolId   : TBytes32;
    tokenIn  : TAddress;
    tokenOut : TAddress;
    amountIn : BigInteger;
    amountOut: BigInteger)
  begin
    // a swap between two tokens happened
  end);

task.Start;
end;

end.
