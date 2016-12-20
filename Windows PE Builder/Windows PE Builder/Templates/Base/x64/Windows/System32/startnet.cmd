@echo off

If exist x:\windows\system32\IME\IMEReg.cmd call x:\windows\system32\IME\IMEReg.cmd

wpeinit

If exist x:\ghost\ghost64.exe start "" x:\ghost\ghost64.exe /ib /fdsp /split=2048
