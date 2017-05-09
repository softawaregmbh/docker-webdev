[CmdletBinding()]
param(
  [Parameter(Mandatory=$true, HelpMessage="Specify the version of the image you want to create. (directories in ./image) [default: 'base']")]
  [String]$image,
  
  [Parameter(Mandatory=$true, HelpMessage="Enter the specified node-version (e.g. 6.10.2) from https://nodejs.org/en/download/releases/.")]
  [String]$node_version,
  
  [switch]$silent,
  
  [switch]$publish
)

$tag = $image + "-" + $node_version
$imagename = "softaware/webdev" + ":" + $tag
$imagepath = "./image/" + $image + "/"
$dockerfile = $imagepath + "Dockerfile"
$generatedfile = $imagepath + "Dockerfile.gen"

$template = Get-Content $dockerfile -Raw
$generated = $template.Replace("{{ node_version }}", $node_version)
$generated | Out-File -Encoding UTF8 $generatedfile

$command = {docker image build (&{If($silent) {"--quiet"}}) --force-rm -f $generatedfile -t $imagename $imagepath}
if (!$silent) {& $command} else {& $command | Out-Null}

"$($imagename) created successfully"

if ($publish) { 
  $command = {docker push $imagename}
  if (!$silent) {& $command} else {& $command | Out-Null}
  "$($imagename) published successfully"
}


Remove-Item $generatedfile
