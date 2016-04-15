@echo off

if exist x:\windows\system32\IME\IMEReg.cmd call x:\windows\system32\IME\IMEReg.cmd

wpeinit

start "" x:\ghost\ghost64.exe /ib /fdsp
