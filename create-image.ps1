[CmdletBinding()]
param(
  [Parameter(Mandatory=$true, HelpMessage="Enter the specified node-version (e.g. 6.10.2) from https://nodejs.org/en/download/releases/.")]
  [String]$node_version,
  
  [Switch]$silent,
  
  [Switch]$publish
)

# ===== CONSTANTS =====
$REPOSITORYNAME = "softaware/webdev"
$IMAGEPATH = "./images/"
$DOCKERFILEROOTPATH = "$($IMAGEPATH)Dockerfile"
$DISTRIBUTIONS = @("alpine","debian")

function Generate-Image {
  param(
    [String]$node_version,
    [String]$distribution,
    [Boolean]$silent,
    [Boolean]$publish
  )

  $generatedfile = $IMAGEPATH + "Dockerfile.gen"

  $dockerfile = $DOCKERFILEROOTPATH + "." + $distribution
  $tag = $distribution + "-" + $node_version
  $imagename = $REPOSITORYNAME + ":" + $tag

  $template = Get-Content $dockerfile -Raw
  $generated = $template.Replace("{{ node_version }}", $node_version)
  $generated | Out-File -Encoding UTF8 $generatedfile

  $command = {docker image build (&{If($silent) {"--quiet"}}) --force-rm -f $generatedfile -t $imagename $IMAGEPATH}
  if (!$silent) {& $command} else {& $command | Out-Null}
  Remove-Item $generatedfile

  "$($imagename) created successfully"

  if ($publish) {
    Publish-Image $imagename
  }
}

function Publish-Image {
  param(
    [String]$imagename
  )
  $command = {docker push $imagename}
  if (!$silent) {& $command} else {& $command | Out-Null}

  "$($imagename) published successfully"
}

function Generate-Images {
  param(
    [String]$node_version,
    [String[]]$distributions,
    [Boolean]$silent,
    [Boolean]$publish
  )
  foreach ($distribution in $distributions) {
    Generate-Image $node_version $distribution $silent $publish
  }
}

Generate-Images $node_version $DISTRIBUTIONS $silent.IsPresent $publish.IsPresent
