@echo off

if exist x:\windows\system32\IME\IMEReg.cmd call x:\windows\system32\IME\IMEReg.cmd

wpeinit

if exist x:\ghost\ghost32.exe start "" x:\ghost\ghost32.exe /split=2048
