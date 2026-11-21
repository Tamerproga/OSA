# Lab 5 — Encoding forensics

## Diagnosis
Before fixing, I checked the original file. The `file` command revealed `Non-ISO extended-ASCII text, with CRLF line terminators`. The hexdump showed bytes like `d4 e0` which correspond to Cyrillic characters in **Windows-1251** encoding. Therefore, the file had two issues: 
1. **Encoding:** Windows-1251 (Cyrillic).
2. **Line endings:** CRLF (Windows format).

## Fix
I wrote a script (`scripts/fix.sh`) that uses `iconv` to convert the file from Windows-1251 to **UTF-8**, and `tr` to remove the carriage return characters (`\r`), changing the line endings to LF (Unix format). The fixed file is saved as `staff-fixed.csv`.

## Verification
After running the script, the `file` command shows that the new file is `UTF-8 Unicode text`. Opening the file with `cat` in the terminal, Excel, and LibreOffice now displays the Kazakh and Russian names correctly without any garbage characters.
