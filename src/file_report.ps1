$Size = 100*1024*1024 # 100 Megabytes (MB) threshold.
$Path = [Environment]::GetFolderPath("Desktop")+"\file_report.csv"
$Title = "C:\Windows" # Graphical user interface title.
$Folder = "C:\Windows"

Get-ChildItem $Folder -Recurse -ErrorAction SilentlyContinue -Force |
Where-Object {$_.length -gt $Size} |
Sort-Object -Descending -Property Length |
Select-Object Name, DirectoryName, @{Name="MB";Expression={[Math]::round($_.length / 1MB, 2)}}, @{Name="Owner";Expression={$_.GetAccessControl().Owner}} |
Out-GridView -Title $Title -PassThru | Export-CSV -Path $Path
