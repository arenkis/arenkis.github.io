# PowerShell script for Windows
# Save as sync-obsidian-quartz.ps1

# Define paths (update these to your Windows paths)
$OBSIDIAN_PUBLIC = "C:\Users\arenk\Sync\Obsidian\Public"
$QUARTZ_CONTENT = "C:\Users\arenk\Sync\Software\quartz\content"
$QUARTZ_DIR = "C:\Users\arenk\Sync\Software\quartz"

# Ensure the destination exists
if (!(Test-Path -Path $QUARTZ_CONTENT)) {
    New-Item -ItemType Directory -Path $QUARTZ_CONTENT -Force
}

# Remove old files in Quartz content folder
if (Test-Path -Path $QUARTZ_CONTENT) {
    Get-ChildItem -Path $QUARTZ_CONTENT -Recurse | Remove-Item -Force -Recurse
}

# Copy new files from Obsidian Public folder to Quartz content
Copy-Item -Path "$OBSIDIAN_PUBLIC\*" -Destination $QUARTZ_CONTENT -Recurse -Force

# Change to Quartz directory
Set-Location -Path $QUARTZ_DIR

# Check if there are changes
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "Changes detected. Committing and pushing..." -ForegroundColor Yellow
    git add .
    git commit -m "Auto-sync from Obsidian Public to Quartz"
    git push origin main
} else {
    Write-Host "No changes detected. Skipping push." -ForegroundColor Green
}

Write-Host "✅ Public folder copied & changes published!" -ForegroundColor Green