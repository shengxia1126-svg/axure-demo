@echo off
chcp 65001 >nul
title Axure Auto Publish - GitHub SSH - Vercel

set PROJECT_DIR=D:\axure-demo
set REPO_URL=git@github.com:shengxia1126-svg/axure-demo.git

echo.
echo =====================================
echo       Axure Auto Publish
echo       GitHub SSH + Vercel Deploy
echo =====================================
echo.

cd /d %PROJECT_DIR%

if errorlevel 1 (
    echo [ERROR] 找不到项目目录:
    echo %PROJECT_DIR%
    pause
    exit /b 1
)

echo [1/6] 检查 Git...

git --version

if errorlevel 1 (
    echo [ERROR] Git 未安装
    pause
    exit /b 1
)


echo.
echo [2/6] 检查 Git 仓库...

if not exist ".git" (
    echo [ERROR] 当前目录不是 Git 仓库
    pause
    exit /b 1
)


echo.
echo [3/6] 配置 SSH Remote...

git remote set-url origin %REPO_URL%


echo.
echo [4/6] SSH 验证...

ssh -T git@github.com 2>&1 | findstr "successfully authenticated" >nul

if errorlevel 1 (
    echo [ERROR] GitHub SSH 验证失败
    echo 请检查 SSH Key 配置
    pause
    exit /b 1
)

echo SSH OK


echo.
echo [5/6] 检查文件修改...

git status

git add .


git diff --cached --quiet

if %errorlevel%==0 (
    echo.
    echo 没有检测到修改
    echo 无需提交
    pause
    exit /b 0
)


echo.
echo 正在提交...

git commit -m "Auto Update %date% %time%"

if errorlevel 1 (
    echo.
    echo [ERROR] Commit 失败
    pause
    exit /b 1
)


echo.
echo [6/6] Push 到 GitHub...

git push origin main

if errorlevel 1 (
    echo.
    echo [ERROR] Push 失败
    pause
    exit /b 1
)


echo.
echo =====================================
echo          发布成功！
echo =====================================
echo.
echo GitHub:
echo %REPO_URL%
echo.
echo Vercel 将自动开始部署...
echo.

pause