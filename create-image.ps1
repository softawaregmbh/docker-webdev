[CmdletBinding()]
param(
  [Parameter(Mandatory=$true, HelpMessage="Enter the specified node-version (e.g. 6.10.2) from https://nodejs.org/en/download/releases/.")]
  [String]$node_version,
  
  [Parameter(HelpMessage="Specify the versions of the image you want to create. (suffixes in ./images; base images are generated by default)")]
  [String]$customized_images = "",
  
  [Switch]$silent,
  
  [Switch]$publish
)

# ===== CONSTANTS =====
$repositoryname = "softaware/webdev"
$imagepath = "./images/"
$dockerfilerootpath = "$($imagepath)Dockerfile"

function Generate-Image {
  param(
    [String]$node_version,
    [String]$image_type,
    [String]$application_type,
    [Boolean]$silent,
    [Boolean]$publish
  )

  $generatedfile = $imagepath + "Dockerfile.gen"

  $dockerfile = $dockerfilerootpath + "." + $image_type + $(If($application_type) { ".$($application_type)" })
  $tag = $image_type + "-" + $node_version + $(If($application_type) { "-$($application_type)" })
  $imagename = $repositoryname + ":" + $tag

  $template = Get-Content $dockerfile -Raw
  $generated = $template.Replace("{{ node_version }}", $node_version)
  $generated | Out-File -Encoding UTF8 $generatedfile

  $command = {docker image build (&{If($silent) {"--quiet"}}) --force-rm -f $generatedfile -t $imagename $imagepath}
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
    [String[]]$image_types,
    [String]$application_type,
    [Boolean]$silent,
    [Boolean]$publish
  )
  foreach ($image_type in $image_types) {
    Generate-Image $node_version $image_type $image $silent $publish
  }
}

$images = @("") + ($customized_images.Split(",") | % { $_.Trim() }) | select -uniq

foreach ($image in $images) {
  Generate-Images $node_version @("alpine","debian") $image $silent.IsPresent $publish.IsPresent
}