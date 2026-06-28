@echo off
chcp 65001 >nul
title Axure Auto Publish

cd /d D:\axure-demo

echo.
echo ===============================
echo      Axure Auto Publish
echo ===============================
echo.

git status

echo.
git add .

git diff --cached --quiet
if %errorlevel%==0 (
    echo.
    echo 没有检测到任何修改，无需提交。
    pause
    exit /b
)

git commit -m "Update %date% %time%"

if errorlevel 1 (
    echo.
    echo Commit 失败！
    pause
    exit /b
)

git push

if errorlevel 1 (
    echo.
    echo Push 失败！
    pause
    exit /b
)

echo.
echo ===============================
echo 发布成功！
echo Vercel 正在自动部署...
echo ===============================
pause