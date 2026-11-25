# Prathi photos folder lo unna photos ni 1.jpg, 2.jpg, 3.jpg... ga rename chestundi (name order lo)
$root = Join-Path $PSScriptRoot '..\photos'
Get-ChildItem $root -Directory | ForEach-Object {
  $dir = $_
  $heic = Get-ChildItem $dir.FullName -File | Where-Object { $_.Extension -match '^\.hei[cf]$' }
  if ($heic) { Write-Host "WARNING $($dir.Name): HEIC photos browser lo open avvavu, JPG ga convert cheyyi" -ForegroundColor Yellow }
  if ($dir.Name -eq '00-cover') { return }
  $files = Get-ChildItem $dir.FullName -File | Where-Object { $_.Extension -match '^\.(jpe?g|png|webp)$' } | Sort-Object Name
  $tmp = @(); $i = 0
  foreach ($f in $files) { $i++; $n = "__tmp_$i" + $f.Extension.ToLower(); Rename-Item -LiteralPath $f.FullName -NewName $n; $tmp += (Join-Path $dir.FullName $n) }
  $i = 0
  foreach ($t in $tmp) { $i++; Rename-Item -LiteralPath $t -NewName ("$i" + [IO.Path]::GetExtension($t)) }
  if ($files.Count) { Write-Host "$($dir.Name): $($files.Count) photos ready" -ForegroundColor Green }
}
Write-Host "`nAyipoyindi! Ippudu index.html open cheyyi"
