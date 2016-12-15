echo off
set filename=%~n1
set copy="%~d1%~p1%filename%-original.pdf"
copy %1 %copy%
rem "C:\Program Files\gs\gs9.20\bin\gswin64c.exe" -sDEVICE=pdfwrite -dCompatibility=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH  -sOutputFile=%1 %1
"C:\Program Files\gs\gs9.20\bin\gswin64c.exe" -sDEVICE=pdfwrite -dCompatibility=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH  -sOutputFile=%1 %copy%
rem Add to not keep original file: -overwrite_original
rem perl.exe "C:\Users\Julien\Downloads\EE\Image-ExifTool-10.36\exiftool" -Creator="NAPS2" -Author="NAPS2" -Producer="NAPS2" -overwrite_original %1
"C:\Program Files\ExifTool\exiftool.exe" -Creator="NAPS2" -Author="NAPS2" -Producer="NAPS2" -overwrite_original %1
set keywords=%filename:-=, %
set keywords=%keywords:_=/%
echo on
"C:\Program Files (x86)\NAPS2\NAPS2.Console.exe" --ocrlang "fra" --enableocr --pdfkeywords "%keywords%" -i %1 -o %1 --force -n 0
set /p delete="Delete original ('n' for no): "
echo off
if NOT "%delete%" == "n" del %copy%
pause