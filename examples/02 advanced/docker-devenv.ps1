$projectname = (Get-Item -Path ".\" -Verbose).Name
try { $projectname = (Get-Content -Raw -Path package.json -ErrorAction Stop | ConvertFrom-Json).Name } catch {} # try to get the project name out of package.json
$projectname = $projectname.Replace(" ", "_")
$containername = $projectname + "-webdev"

docker container run -it --rm -p 4200:4200 -v ${pwd}:/usr/src/app --name ${containername} softaware/webdev:angular-6.10.3
