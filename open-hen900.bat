@echo off
REM Local convenience launcher only - not part of the tracked site, never committed.
REM Opens hen\900\index.html directly, skipping every other duplicate firmware folder
REM (505, 672, 900a, 900c, 900n, 900-old, 900-usb, restore\*, etc.).
start "" "%~dp0hen\900\index.html"
