@echo off
chcp 65001 >nul
title Axure GitHub Auto Push SSH

echo ===============================
echo   Axure GitHub SSH Auto Setup
echo ===============================

cd /d D:\axure-demo

echo.
echo [1] 檢查 Git...
git --version

echo.
echo [2] 設置 SSH Remote...
git remote set-url origin git@github.com:shengxia1126-svg/axure-demo.git

echo.
echo [3] 檢查 SSH Key...

if not exist "%USERPROFILE%\.ssh\id_ed25519" (
    echo 沒有 SSH Key，正在生成...

    ssh-keygen -t ed25519 -C "shengxia1126@gmail.com" -f "%USERPROFILE%\.ssh\id_ed25519" -N ""

    echo SSH Key 生成完成
) else (
    echo 已存在 SSH Key
)

echo.
echo [4] 啟動 SSH Agent...

powershell -Command "Start-Service ssh-agent"

ssh-add "%USERPROFILE%\.ssh\id_ed25519"


echo.
echo [5] 測試 GitHub SSH...

ssh -T git@github.com


echo.
echo ===============================
echo 請把下面公鑰添加到 GitHub
echo ===============================
echo.

type "%USERPROFILE%\.ssh\id_ed25519.pub"


echo.
echo ===============================
echo 添加完成後重新執行本文件
echo ===============================

pause


echo.
echo [6] Push 最新代碼...

git add .

git commit -m "Auto Update %date% %time%"

git push

if errorlevel 1 (
    echo.
    echo Push 失敗
    pause
    exit /b
)


echo.
echo ===============================
echo      發布成功！
echo ===============================

pause