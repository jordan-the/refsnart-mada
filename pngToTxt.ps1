# Load the Windows Forms assembly to enable message box functionality
Add-Type -AssemblyName System.Windows.Forms

# Define folder paths for source images, destination PDFs, and queued PDFs
$sourceFolder = "C:\Users\jthe\Documents\Automation\pdf-extraction\temp"
$destinationFolder = "C:\Users\jthe\Documents\Automation\pdf-extraction\output"
$queueFolder = "C:\Users\jthe\Documents\Automation\pdf-extraction\queue"

# Process each PNG file in the source folder recursively
Get-ChildItem -Path $sourceFolder -Filter *.png -Recurse | ForEach-Object {
    $pngPath = $_.FullName
    $baseName = $_.BaseName

    try {
        # Extract text from the image using a custom OCR function
        $text = (Convert-PsoImageToText -Path $pngPath).Text

        # Extract passenger name using regex
        $nameMatch = [regex]::Match($text, "(?<=Passenger\(s\):\s)(?<lastName>\w+) \/ (?<firstName>\w+)")
        if ($nameMatch.Success) { 
            $firstName = $nameMatch.Groups["firstName"].Value
            $firstName = $firstName.Substring(0,1).ToUpper()  # Use only the first initial
            $lastName = $nameMatch.Groups["lastName"].Value
            #Write-Host "First Name: $firstName, Last Name: $lastName"
        } else {
            throw "Name not found" 
        }

        # Extract booking date using regex
        $bookedMatch = [regex]::Match($text, "(?<=Web\s)(?<day>\d+)-(?<month>\w+)-(?<year>\d+)")
        if ($bookedMatch.Success) { 
            $bookedDay = $bookedMatch.Groups["day"].Value
            $bookedMonth = $bookedMatch.Groups["month"].Value
            $bookedYear = $bookedMatch.Groups["year"].Value
            #Write-Host "Date Booked: $bookedDay-$bookedMonth-$bookedYear"
        } else {
            throw "Date Booked not found" 
        }

        # Extract travel date using regex
        $travelMatch = [regex]::Match($text, "(?<=Departure Date: )(?<day>\d+)-(?<month>\w+)-(?<year>\d+)")
        if ($travelMatch.Success) { 
            $travelDay = $travelMatch.Groups["day"].Value
            $travelMonth = $travelMatch.Groups["month"].Value
            $travelYear = $travelMatch.Groups["year"].Value
            #Write-Host "Date Travelled: $travelDay-$travelMonth-$travelYear"
        } else {
            throw "Date Travelled not found" 
        }

        # Construct source and destination file paths
        $sourceFile = Join-Path $queueFolder "$baseName.pdf"
        $destinationFile = Join-Path $destinationFolder "$firstName $lastName Airfare $travelDay$travelMonth$travelYear $bookedDay$bookedMonth$bookedYear $baseName.pdf"

        # Move the PDF from queue to output with the new name, replacing if it already exists
        Move-Item -Path $sourceFile -Destination $destinationFile -Force

        Remove-Item -Path $pngPath
    }
    catch {
        # Show an error message box if any step fails
        [System.Windows.Forms.MessageBox]::Show(
            "Error processing '$baseName'`nError: $_`nPlease process manually",
            "Processing Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
}