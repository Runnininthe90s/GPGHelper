# GPG Helper

A native, Windows-friendly GUI built in PowerShell for managing GPG encryption, decryption, and your local keyring.

<img width="780" height="475" alt="image" src="https://github.com/user-attachments/assets/531763d5-5534-4c31-9bee-4e972a69b321" />

## Overview
GPG Helper provides an easy-to-use interface for common GnuPG (`gpg.exe`) tasks. It simplifies file encryption/decryption, prevents you from having to type complex GPG commands, and offers a straightforward way to manage your public and secret keys.

## Features
- **Encrypt:** Securely encrypt files for a recipient using a simple dropdown populated from your keyring.
- **Decrypt:** Decrypt incoming files with your secret keys or passphrases.
- **Manage Keys:** Easily view, export, and delete keys from your keyring in a centralized UI.
- **Import Keys:** Quickly add a recipient's public key (`.pub`) directly to your keychain.
- **Standalone Launcher:** A provided C# file allows you to compile a native Windows executable (`GPGLauncher.exe`) to start the GUI silently without PowerShell console windows flashing.

## Requirements
- Windows (PowerShell 5.1+)
- GnuPG (`gpg.exe`) installed on the system (e.g., via Gpg4win or standalone CLI).

## Setup / Compiling the Launcher
Since compiled executables are not included in the repository, you can compile the `.exe` launcher from the provided `GPGLauncher.cs` source file using the built-in C# compiler (`csc.exe`) that comes with the .NET Framework on Windows. 

Run the following command in PowerShell or Command Prompt from the tool's directory:
```cmd
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe /target:winexe /out:GPGLauncher.exe GPGLauncher.cs
```
This compiles `GPGLauncher.cs` into a standalone native Windows executable (`GPGLauncher.exe`) that silently launches `GPGHelper.ps1` in the background.

## Usage
1. Run the newly compiled `GPGLauncher.exe` to open the GUI (or alternatively, run `GPGHelper.ps1` directly in PowerShell).
2. The first time you launch it, navigate to the **Options** tab and specify the path to your `gpg.exe`. The tool will remember your path and settings in a local `settings.json` file.
3. Import public keys using the **Import Key** tab, or manage your existing ones under **Manage Keys**.
4. Use the **Encrypt** and **Decrypt** tabs for file operations.

## Customization
To customize the branding of the tool, simply place an image named `logo.png` in the same directory as the script. The tool will automatically detect it and display it on the main application screens.
