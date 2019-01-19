unit UMainForm;
{
  This file is part of Pascal Microcontroller Board Framework (MBF)
  Copyright (c) 2015 -  Michael Ring
  based on Pascal eXtended Library (PXL)
  Copyright (c) 2000 - 2015  Yuriy Kotsarenko

  This program is free software: you can redistribute it and/or modify it under the terms of the FPC modified GNU
  Library General Public License for more

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the FPC modified GNU Library General Public
  License for more details.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button2: TButton;
    FontDialog1: TFontDialog;
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    RadioGroup1: TRadioGroup;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Memo1: TMemo;
    Label2: TLabel;
    Button1: TButton;
    FileSaveDialog1: TFileSaveDialog;
    Button3: TButton;
    FileOpenDialog1: TFileOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure RefreshControls(Sender: TObject);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var Form1: TForm1;

implementation

uses
  System.UITypes;

{$R *.dfm}

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  RefreshControls(Self);
end;

procedure TForm1.RefreshControls(Sender: TObject);
const CharsPerRow = 24;
var charHeight, charWidth: integer; Pixel: TColor; TheRect: TRect; scalingFactor, i, character, startX, startY, x, y: integer;
  Grey, Grey2: byte; MagFactor: integer; saveCursor: TCursor; activeLabel: TLabel; charBitmap: TBitmap;

begin
  Application.ProcessMessages;
  Application.ProcessMessages;
  Application.ProcessMessages;
  Application.ProcessMessages;
  MagFactor := 8;
  saveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  charBitmap := TBitmap.Create;
  charBitmap.width := 200;
  charBitmap.height := 200;
  charBitmap.pixelFormat := pf24bit;
  charBitmap.Canvas.Font := FontDialog1.Font;
  charBitmap.Canvas.Font.height := SpinEdit1.Value;
  if RadioGroup1.ItemIndex = 0 then
    charBitmap.Canvas.Font.Quality := fqAntialiased;
  if RadioGroup1.ItemIndex = 1 then
    charBitmap.Canvas.Font.Quality := fqClearType;
  if RadioGroup1.ItemIndex = 2 then
    charBitmap.Canvas.Font.Quality := fqClearTypeNatural;
  if RadioGroup1.ItemIndex = 3 then
    charBitmap.Canvas.Font.Quality := fqNonAntialiased;
  charHeight := 0;
  charWidth := 0;
  for i := 0 to 255 do
  begin
    if charHeight < charBitmap.Canvas.TextHeight(chr(i)) then
      charHeight := charBitmap.Canvas.TextHeight(chr(i));
    if charWidth < charBitmap.Canvas.TextWidth(chr(i)) then
      charWidth := charBitmap.Canvas.TextWidth(chr(i));
  end;

  StatusBar1.Panels.Items[0].Text := 'FontName : ' + FontDialog1.Font.Name + ' FontHeight : ' + charHeight.ToString +
    ' px FontWidth : ' + charWidth.ToString + ' px';

  // Scrollbox1.Top := Label4.Top + Label4.Height+1;
  Image1.Top := 0;
  Image1.Left := 0;
  Image1.width := 32 * charWidth * MagFactor;
  Image1.height := 8 * charHeight * MagFactor;
  Image1.Picture.Bitmap.width := 32 * charWidth * MagFactor;
  Image1.Picture.Bitmap.height := 8 * charHeight * MagFactor;
  Image1.Refresh;
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.FillRect(TRect.Create(0, 0, Image1.width, Image1.height));

  Application.ProcessMessages;
  Application.ProcessMessages;
  Application.ProcessMessages;
  Application.ProcessMessages;

  startX := 0;
  startY := 0;

  for character := 0 to 255 do
  begin
    // charBitmap.Canvas.Pen.Color := clWhite;
    charBitmap.Canvas.Pen.Color := clBlack;
    charBitmap.Canvas.Brush.Color := clWhite;
    charBitmap.Canvas.FillRect(TRect.Create(0, 0, 99, 99));
    // charBitmap.Canvas.Brush.Color := clBlack;
    charBitmap.Canvas.TextOut(0, 0, chr(character));

    for x := 0 to charWidth - 1 do
      for y := 0 to charHeight - 1 do
      begin
        startX := (character) * charWidth - ((character) div 32) * charWidth * 32;
        var
        offsetX := (character) * charWidth;
        startY := ((character) div 32) * charHeight;
        TheRect.Top := y * MagFactor + startY * MagFactor;
        TheRect.Left := x * MagFactor + startX * MagFactor;
        TheRect.Right := TheRect.Left + MagFactor;
        TheRect.Bottom := TheRect.Top + MagFactor;
        // Pixel := activeLabel.Canvas.Pixels[x + OffsetX, y];
        Pixel := charBitmap.Canvas.Pixels[x, y];
        Grey := Round(TColorRec(Pixel).R * 0.30 + TColorRec(Pixel).G * 0.59 + TColorRec(Pixel).B * 0.11);
        if Grey < 64 then
          Grey2 := 0;
        if Grey > 64 then
          Grey2 := 1;
        if Grey > 128 then
          Grey2 := 2;
        if Grey > 192 then
          Grey2 := 3;

        (* if ComboBox3.ItemIndex = 0 then
          if Grey2 <= 1 then
          Grey2 := 0
          else
          Grey2 := 3;
        *)
        if String(Memo1.Text).contains(chr(character)) then
          scalingFactor := 85
        else
          scalingFactor := 80;

        TColorRec(Pixel).R := Grey2 * scalingFactor;
        TColorRec(Pixel).G := Grey2 * scalingFactor;
        TColorRec(Pixel).B := Grey2 * scalingFactor;

        Image1.Canvas.Brush.Color := Pixel;
        Image1.Canvas.FillRect(TheRect);
      end;
  end;

  Screen.Cursor := saveCursor;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  FontDialog1.Font.Size := SpinEdit1.Value;
  RefreshControls(Self);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, x, y: integer;
  f : textFile;
begin
  var saveCursor := Screen.Cursor;
  Application.ProcessMessages;

  var charBitmap := TBitmap.Create;
  charBitmap.width := 10;
  charBitmap.height := 10;
  charBitmap.pixelFormat := pf24bit;
  charBitmap.Canvas.Font := FontDialog1.Font;
  charBitmap.Canvas.Font.height := SpinEdit1.Value;
  var antialiasedFont := true;
  if RadioGroup1.ItemIndex = 0 then
    charBitmap.Canvas.Font.Quality := fqAntialiased;
  if RadioGroup1.ItemIndex = 1 then
    charBitmap.Canvas.Font.Quality := fqClearType;
  if RadioGroup1.ItemIndex = 2 then
    charBitmap.Canvas.Font.Quality := fqClearTypeNatural;
  if RadioGroup1.ItemIndex = 3 then
  begin
    charBitmap.Canvas.Font.Quality := fqNonAntialiased;
    antialiasedFont := false;
  end;
  var charHeight := 0;
  var charWidth := 0;
  for i := 0 to 255 do
  begin
    if charHeight < charBitmap.Canvas.TextHeight(chr(i)) then
      charHeight := charBitmap.Canvas.TextHeight(chr(i));
    if charWidth < charBitmap.Canvas.TextWidth(chr(i)) then
      charWidth := charBitmap.Canvas.TextWidth(chr(i));
  end;

  charBitmap.Width := charWidth;
  charBitmap.Height := charHeight;

  var FontName : String := FontDialog1.Font.Name + charWidth.ToString + 'x' + charHeight.ToString;
  if antialiasedFont = true then
    FontName := FontName + '_antialiased';
  FontName := FontName.replace(' ', '');
  FileSaveDialog1.FileName := 'MBF.Fonts.' + FontName + '.pas';
  if FileSaveDialog1.Execute = true then
  begin
    Screen.Cursor := crHourGlass;
    assignfile(f, FileSaveDialog1.FileName);
    rewrite(f);
    writeln(f, 'unit MBF.Fonts.' + FontName + ';');
    writeln(f, '{$mode objfpc}');
    writeln(f, '{$WRITEABLECONST OFF}');

    writeln(f, 'interface');
    writeln(f, 'uses');
    writeln(f, '  MBF.Displays.CustomDisplay;');

    var dataSize : integer;

    dataSize := ((charWidth-1) div 8 + 1) * charHeight;
    if antialiasedFont = true then
      dataSize := ((charWidth-1) div 4 + 1) * charHeight;

    var requiredChars := '';
    for i := 0 to 255 do
    begin
      if String(Memo1.Text).contains(chr(i)) then
        requiredChars := requiredChars + chr(i);
    end;

    writeln(f, 'const');
    writeln(f, '  ' + FontName + '_FontData : array[0..' + (Length(requiredChars) - 1).ToString + '] of array[0..' + (DataSize - 1).ToString +
      '] of byte = ');

    var k := 0;
    writeln(f, '  (');
    for i := 1 to length(requiredChars) do
    begin
      charBitmap.Canvas.Pen.Color := clBlack;
      charBitmap.Canvas.Brush.Color := clWhite;
      charBitmap.Canvas.FillRect(TRect.Create(0, 0, charWidth, charHeight));
      charBitmap.Canvas.TextOut(0, 0, requiredChars[i]);
      writeln(f, '    (');

      for y := 0 to charHeight - 1 do
      begin
        var CharData := '';
        for x := 0 to charWidth - 1 do
        begin
          var Grey : byte;
          var Grey2 : String;

          var Pixel := charBitmap.Canvas.Pixels[x, y];
          Grey := Round(TColorRec(Pixel).R * 0.30 + TColorRec(Pixel).G * 0.59 + TColorRec(Pixel).B * 0.11);

          if antialiasedFont = false then
          begin
            if Grey <= 127 then
              Grey2 := '1'
            else
              Grey2 := '0';
          end
          else
          begin
            if Grey < 64 then
              Grey2 := '11';
            if Grey > 64 then
              Grey2 := '10';
            if Grey > 128 then
              Grey2 := '01';
            if Grey > 192 then
              Grey2 := '00';
          end;
          CharData := CharData + Grey2;
        end;
        while (Length(CharData) div 8) * 8 <> Length(CharData) do
          CharData := CharData + '0';
        var Line := '    ';
        for var j := 0 to (CharData.Length div 8) - 1 do
        begin
          Line := Line + '%' + CharData[j * 8 + 1] + CharData[j * 8 + 2] + CharData[j * 8 + 3] + CharData[j * 8 + 4] +
            CharData[j * 8 + 5] + CharData[j * 8 + 6] + CharData[j * 8 + 7] + CharData[j * 8 + 8] + ',';
        end;
        if y < charHeight - 1 then
          writeln(f, Line)
        else
          writeln(f, Line.Remove(Line.Length - 1));
      end;
      if i <> length(requiredChars) then
        writeln(f, '    ),')
      else
        writeln(f, '    )')
    end;
    writeln(f, '  );');
    writeln(f);
    writeln(f,'const');
    writeln(f,'  '+FontName+' : TFontInfo =');
    writeln(f,'  (');
    writeln(f,'    Width : '+charWidth.ToString+';');
    writeln(f,'    Height : '+charHeight.ToString+';');
    if antialiasedFont = false then
      writeln(f,'    BitsPerPixel : 1;')
    else
      writeln(f,'    BitsPerPixel : 2;');
    writeln(f,'    BytesPerChar : '+dataSize.ToString+';');
    writeln(f,'    Charmap : '''+requiredChars.replace('''','''''')+''';');
    writeln(f,'    pFontData : @'+FontName+'_FontData;');
    writeln(f,'  );');
    writeln(f);
    writeln(f, 'implementation');
    writeln(f, 'end.');
    closeFile(f);
  end;
  Screen.Cursor := saveCursor;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if FontDialog1.Execute = true then
    RefreshControls(Self);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute = true then
  begin
    var f: TextFile;
    assignfile(f, FileOpenDialog1.FileName);
    reset(f);
    var
    tmp := '';
    var character: AnsiChar;
    while eof(f) = false do
    begin
      System.read(f, character);
      if not tmp.contains(character) then
        tmp := tmp + character;
    end;
    Memo1.Text := tmp;
    RefreshControls(Self);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i: byte;
begin
  FontDialog1.Font.Name := 'Courier New';
  SpinEdit1.Value := 16;
  FontDialog1.Font.height := 16;
  Memo1.Text := '';
  for i := 32 to 127 do
    Memo1.Text := Memo1.Text + chr(i);
  RefreshControls(Self);
end;

end.
