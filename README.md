📦 Installation Guide for PsOcr
🧩 Dependencies 
Before using PsOcr, make sure the following dependencies are installed:
PowerShell 5.1+ or PowerShell Core
Poppler for Windows – used for PDF rendering and OCR support
👉 https://github.com/oschwartz10612/poppler-windows/releases

🛠️ Step 1: Install the Module
Open PowerShell and run:
Install-Module -Name PsOcr -Scope CurrentUser
Get-Module -ListAvailable PsOcr

📥Step 2: Download Poppler for Windows

Visit the https://github.com/oschwartz10612/poppler-windows/releases.
Download the latest release .zip file.
Extract the contents to a folder of your choice.

⚙️ Step 3: Add Poppler to Your System PATH
To make Poppler accessible from anywhere:

Press Win + S and search for "environment variables".
Click Edit the system environment variables.
In the System Properties window, click Environment Variables....
Under System variables, find and select the Path variable, then click Edit.
Click New and add the path to the bin folder inside the extracted Poppler directory (e.g., C:\Tools\poppler-xx\bin).
Click OK to close all dialogs.

✅ You're all set! You can now use PsOcr with Poppler support in your PowerShell environment.