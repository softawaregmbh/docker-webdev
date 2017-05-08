[CmdletBinding()]
param(
  [Parameter(Mandatory=$true, HelpMessage="Enter the specified node-version (e.g. 6.10.2) from https://nodejs.org/en/download/releases/.")]
  [String]$node_version
)

$tag = "node-" + $node_version
$imagename = "softaware/webdev" + ":" + $tag
$imagepath = "./image/"
$dockerfile = $imagepath + "Dockerfile"
$generatedfile = $imagepath + "Dockerfile.gen"

$template = Get-Content $dockerfile -Raw
$generated = $template.Replace("{{ node_version }}", $node_version)
$generated | Out-File -Encoding UTF8 $generatedfile
docker image build -f $generatedfile --build-arg VCS_REF=${git rev-parse --short HEAD} -t $imagename $imagepath
docker push $imagename
Remove-Item $generatedfile
