unit JD.GitHub.Install;

interface

uses
  System.Classes,
  JD.GitHub;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GitHub', [TGitHub]);
end;

end.
