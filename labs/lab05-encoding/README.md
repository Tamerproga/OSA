# Lab 5 — Encoding forensics

## Diagnosis Before Fix
- **Source encoding:** KZ-1048 (RK1048) (not Windows-1251; e.g. byte 0xA3 maps to Kazakh Ә in KZ-1048 rather than Ҹ/J in Windows-1251).
- **Line endings:** CRLF (
).
- **Byte Order Mark (BOM):** None initially (no UTF-8 BOM EF BB BF at byte 0).
- **Field delimiter / separator:** semicolon (;).

## BOM Decision
Add a UTF-8 BOM (EF BB BF) to staff-fixed.csv so Excel recognizes UTF-8 automatically when opening the CSV file directly (such as via double-click) without garbled Cyrillic/Kazakh characters, while normalizing line endings to LF.

## Fix Script & Conversion
Converted from KZ-1048 to UTF-8 via iconv, normalized line endings, and prepended the UTF-8 BOM using scripts/fix.sh.

## Verification
Verified output in terminal (file, hexdump/cat) and desktop spreadsheet/text viewers; see evidence/file-before.txt, evidence/hexdump-before.txt, evidence/file-after.txt, evidence/staff-broken.csv, and evidence/staff-fixed.csv.

## What did not work
Attempt 1 treated the file as Windows-1251 instead of KZ-1048 (causing wrong Kazakh letters such as Ә/Қ/Ң), omitted a BOM (needed by Excel for direct UTF-8 recognition), did not explicitly name the delimiter in README, and had a mismatch between claimed viewers and screenshots.
