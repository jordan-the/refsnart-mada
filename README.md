# 📘 PsOcr Installation Guide

A step-by-step guide to installing and setting up **PsOcr**, a PowerShell module for OCR and PDF rendering using Poppler.

---

## 🧩 Dependencies

Before using **PsOcr**, ensure the following are installed:

- **PowerShell 5.1+** or **PowerShell Core**
- **Poppler for Windows** – used for PDF rendering and OCR support  
  👉 https://github.com/oschwartz10612/poppler-windows/releases

---

## 🛠️ Step 1: Install the PsOcr Module

Open PowerShell and run:

```powershell
Install-Module -Name PsOcr -Scope CurrentUser
Get-Module -ListAvailable PsOcr
```

---

## 📥 Step 2: Download Poppler for Windows

1. Visit the https://github.com/oschwartz10612/poppler-windows/releases page  
2. Download the latest `.zip` release  
3. Extract the contents to a folder of your choice

---

## ⚙️ Step 3: Add Poppler to Your System PATH

To make Poppler accessible from anywhere:

1. Press **Win + S** and search for "environment variables"  
2. Click **Edit the system environment variables**  
3. In the **System Properties** window, click **Environment Variables...**  
4. Under **System variables**, find and select the **Path** variable, then click **Edit**  
5. Click **New** and add the path to the `bin` folder inside the extracted Poppler directory  
   Example:  
   ```
   C:\Tools\poppler-xxin
   ```
6. Click **OK** to close all dialogs

---

## 📂 Step 4: Configure Script File Paths

Update the following variables in the scripts to match your folder structure:

### `pdfToPng.ps1`

```powershell
$sourceFolder      # Path to your PDF files
$destinationFolder # Path to temporarily store PNG files
```

### `pngToTxt.ps1`

```powershell
$sourceFolder      # Path to PNG files
$destinationFolder # Path to save renamed PDFs
$queueFolder       # Path to original PDFs
```

---

## ✅ You're All Set!