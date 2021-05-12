unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.ExtCtrls, JvExExtCtrls, JvImage, IPPeerClient, REST.Client,
  REST.Authenticator.OAuth, Data.Bind.Components, Data.Bind.ObjectScope,System.IOUtils, rest.types, Vcl.ComCtrls, System.JSON;
const
   urlvisual =   'https://gateway.watsonplatform.net/visual-recognition/api/v3/classify?version=2018-03-19';
   urlfaces    = 'https://gateway.watsonplatform.net/visual-recognition/api/v3/detect_faces?version=2018-03-19';
   urlexplicit = 'https://gateway.watsonplatform.net/visual-recognition/api/v3/classify?version=2018-03-19&classifier_ids=explicit';
   urlfood =     'https://gateway.watsonplatform.net/visual-recognition/api/v3/classify?version=2018-03-19&classifier_ids=food';
   //urltone =     'https://gateway.watsonplatform.net/visual-recognition/api/v3/classify?version=2018-03-19&classifier_ids ';
type
  TForm2 = class(TForm)
    Button2: TButton;
    JvFilenameEdit1: TJvFilenameEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    rgTipo: TRadioGroup;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    JvImage1: TJvImage;
    OAuth2Authenticator1: TOAuth2Authenticator;
    Button1: TButton;
    resultado: TMemo;
    procedure JvFilenameEdit1AfterDialog(Sender: TObject; var AName: string; var AAction: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure RestDefault;
    { Private declarations }
  public
    function RequestToken (const apikey : string): string;

  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  RequestToken( 'yPz5viRpCQynm_m-m2x89sf3_vcza1W5G6EV6smGv4ca');
end;

procedure TForm2.Button2Click(Sender: TObject);
var token : string;
    abytes : TBytes;
    objresult : TJSONObject;
begin
  token:=  RequestToken( 'yPz5viRpCQynm_m-m2x89sf3_vcza1W5G6EV6smGv4ca');
  RestDefault;
  case rgTipo.ItemIndex of
    0: RESTClient1.BaseURL := urlvisual;
    1: RESTClient1.BaseURL := urlfaces;
    2: RESTClient1.BaseURL := urlexplicit;
    3: RESTClient1.BaseURL := urlfood;
    else
     RESTClient1.BaseURL := urlvisual;
  end;
  RESTClient1.Authenticator := OAuth2Authenticator1;

 OAuth2Authenticator1.AccessToken:= token;
  abytes := TFile.ReadAllBytes(JvFilenameEdit1.Text);
  RESTRequest1.Method := rmPOST;
  RESTRequest1.Params.Clear;
  RESTRequest1.Params.AddItem('images_file',abytes , pkGETorPOST, [poDoNotEncode],ctIMAGE_JPEG);
  RESTRequest1.Params.AddItem('Accept-Language', 'pt-br', pkHTTPHEADER);
  //RESTRequest1.Params.AddItem('apikey', token, pkURLSEGMENT);
  try
    RESTRequest1.Execute;
    objresult :=  RESTResponse1.JsonValue as TJSONObject;
    resultado.Clear;
    resultado.Text :=  objresult.ToJSON  ;
    PageControl1.ActivePage := TabSheet2;
  except
  on e:exception do
  begin
    raise Exception.Create(e.Message);
  end;

  end;
  RESTResponse1.Content;
end;

procedure TForm2.JvFilenameEdit1AfterDialog(Sender: TObject; var AName: string; var AAction: Boolean);
var img: TStream;
    lo : TImage;
begin
  JvImage1.Picture := nil;
  if AName <> '' then
   JvImage1.Picture.LoadFromFile(aname);
  PageControl1.ActivePage := TabSheet1;
end;



function TForm2.RequestToken(const apikey: string): string;
var strparams : string;
objresult : TJSONObject;
begin

  strparams := 'grant_type=urn:ibm:params:oauth:grant-type:apikey&response_type=cloud_iam&apikey='+apikey;
  RestDefault;

  RESTClient1.BaseURL := 'https://iam.cloud.ibm.com/identity/token';
  RESTRequest1.Method := TRESTRequestMethod.rmPOST;
  //RESTRequest1.Params.Clear;
  //RESTRequest1.AddAuthParameter('Authorization','Basic',pkHTTPHEADER);
  RESTRequest1.Params.AddItem('grant_type', 'urn:ibm:params:oauth:grant-type:apikey');
  RESTRequest1.Params.AddItem('apikey', apikey);

  RESTRequest1.Body.Add(strparams,TRESTContentType.ctAPPLICATION_X_WWW_FORM_URLENCODED);
  RESTRequest1.Execute();
   objresult :=  RESTResponse1.JsonValue as TJSONObject;
  result := objresult.Values['access_token'].Value;
end;

procedure TForm2.RestDefault;
begin
  RESTClient1.ResetToDefaults;
  RESTRequest1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;
  RESTClient1.Authenticator := nil;
  RESTClient1.ContentType := 'application/x-www-form-urlencoded';
  RESTRequest1.Accept := 'application/json';
  //, text/json, application/xml, text/xml';
  RESTRequest1.AcceptCharset := '';
end;

end.
