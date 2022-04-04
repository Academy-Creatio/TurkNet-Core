# .\createImage.ps1 -imgName creatiostudio
param($imgName)
$imageCmd = "docker build -f Dockerfile -t ${imgname} .";
Invoke-Expression $imageCmd;
