# Lab 5 — Encoding forensics

## Diagnosis Before Fix
- **Source encoding:** KZ-1048 (RK1048) (not Windows-1251; byte 0xA3 is Kazakh Ә in KZ-1048 rather than J in Windows-1251).
- **Line endings:** CRLF (
).
- **Byte Order Mark (BOM):** None initially (no UTF-8 BOM EF BB BF at byte 0).
- **Field delimiter / separator:** semicolon (;).

## BOM Decision
Add a UTF-8 BOM (EF BB BF) to staff-fixed.csv so Excel (and spreadsheet tools) recognize UTF-8 on double-click without garbled Kazakh or Russian characters, while normalizing line endings.

## Fix Script & Conversion
Converted from KZ-1048 to UTF-8 via iconv, normalized line endings, and prepended the UTF-8 BOM using scripts/fix.sh.

## Verification
Checked the fixed file in three applications captured in evidence (Apple Numbers, Visual Studio Code, and macOS Terminal), alongside file and hexdump/cat output in evidence/file-before.txt, evidence/hexdump-before.txt, evidence/file-after.txt, evidence/staff-broken.csv, and evidence/staff-fixed.csv.

## What did not work
Attempt 1 decoded the source as Windows-1251 instead of KZ-1048 (producing wrong Kazakh letters such as Ә/Қ/Ң), omitted a UTF-8 BOM needed for Excel to recognize UTF-8 on direct open, did not state the delimiter explicitly in README, and had a mismatch between claimed viewers and the screenshots in evidence.
