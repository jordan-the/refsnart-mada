# Run pdfToPng.ps1
Write-Host "Running pdfToPng.ps1..."
& ".\pdfToPng.ps1"

# Check if the previous script ran successfully
if ($LASTEXITCODE -eq 0) {
    Write-Host "pdfToPng.ps1 completed successfully."

    # Run pngToTxt.ps1
    Write-Host "Running pngToTxt.ps1..."
    & ".\pngToTxt.ps1"

    if ($LASTEXITCODE -eq 0) {
        Write-Host "pngToTxt.ps1 completed successfully."
    } else {
        Write-Host "pngToTxt.ps1 encountered an error."
    }
} else {
    Write-Host "pdfToPng.ps1 encountered an error. Aborting."
}
