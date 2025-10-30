$sourceFolder = "C:\Your\File\Path"
$destinationFolder = "C:\Your\DestinationFile\Path"

# Ensure output folder exists
if (!(Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}

# Get all PDF files recursively
Get-ChildItem -Path $sourceFolder -Filter *.pdf -Recurse | ForEach-Object {
    $pdfPath = $_.FullName
    $baseName = $_.BaseName
    $outputPrefix = Join-Path $destinationFolder $baseName

    # Run pdftoppm to extract the first page as PNG
    pdftoppm -png -f 1 -l 1 "$pdfPath" "$outputPrefix"

    # Rename the output file from baseName-1.png to baseName.png
    $generatedFile = "$outputPrefix-1.png"
    $finalFile = "$outputPrefix.png"
    if (Test-Path $generatedFile) {
        Rename-Item -Path $generatedFile -NewName $finalFile
    }
}