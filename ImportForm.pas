
procedure TImportForm.BtnFileClick(Sender: TObject);
Var
    i : Integer;
begin
    If OpenDlg.Execute Then Begin
        LstFiles.Items.Clear;
        If OpenDlg.Files.Count > 0 Then Begin
            For i := 0 To OpenDlg.Files.Count - 1 Do Begin
                LstFiles.Items.Add(OpenDlg.Files[i]);
            End;
        End Else Begin
            LstFiles.Items.Add(OpenDlg.FileName);
        End;
    End;
end;

procedure TImportForm.BtnImportClick(Sender: TObject);
begin
    ImportAllAscIIData(LstFiles.Items, TxtLibName.Text);
    Close;
end;

