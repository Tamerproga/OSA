#!/bin/bash
# Converting from Windows-1251 to UTF-8 and removing CRLF line endings
iconv -f WINDOWS-1251 -t UTF-8 evidence/staff-broken.csv | tr -d '\r' > evidence/staff-fixed.csv
