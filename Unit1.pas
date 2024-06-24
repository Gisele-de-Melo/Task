unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Threading;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure PerformTimeConsumingTask;
    procedure UpdateUIAfterTask;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  // Desativar o botão para evitar múltiplos cliques
  Button1.Enabled := False;
  Label1.Caption := 'Processando...';

  // Executar a tarefa em um thread separado
  TTask.Run(procedure
  begin
    PerformTimeConsumingTask;
    TThread.Synchronize(nil, UpdateUIAfterTask);
  end);
end;

procedure TForm1.PerformTimeConsumingTask;
begin
  // Simular uma operação demorada
  Sleep(5000); // Pausar por 5 segundos
end;

procedure TForm1.UpdateUIAfterTask;
begin
  // Atualizar a interface do usuário após a conclusão da tarefa
  Label1.Caption := 'Tarefa concluída!';
  Button1.Enabled := True;
end;

end.
