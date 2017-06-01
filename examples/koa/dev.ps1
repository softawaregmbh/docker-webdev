param(
    [String]$command
)

# --- constants --- #
$PORT = "3000"
$PORTMAPPING = "$($PORT):3000"
$IMAGE = "softaware/webdev:alpine-8.0.0"
$CONTAINERNAME = "koa-webdev"

# --- available commands --- #
$START = "start"
$SHELL = "shell"
$BACKGROUND = "background"
$BACKGROUND_STOP = "background-stop"
$INTERACTIVE = "interactive"

function Print-Usage() {
    "--- USAGE ---"
    Print-Command-Help $START "runs 'npm start': application available at http://localhost:$($PORT)"
    Print-Command-Help $SHELL "launches a bash in the root folder with npm, node and yarn installed"
    Print-Command-Help $BACKGROUND "runs 'npm start' in the background: application available at http://localhost:$($PORT)"
    Print-Command-Help $BACKGROUND_STOP "stops and removes the previously ran container"
    Print-Command-Help $INTERACTIVE "launches a bash with Port $($PORT) mapped; run your npm commands afterwards"
}

function Print-Command-Help($command, $help) {
    "$($command.PadRight(25))$($help)"
}

switch ($command) 
{ 
    $START { docker container run -it --rm -p $PORTMAPPING -v ${pwd}:/usr/src/app $IMAGE npm start }
    $SHELL { docker container run -it --rm -v ${pwd}:/usr/src/app $IMAGE }
    $BACKGROUND { docker container run -d --rm -p $PORTMAPPING -v ${pwd}:/usr/src/app --name $CONTAINERNAME $IMAGE npm start }
    $BACKGROUND_STOP { docker container stop $CONTAINERNAME }
    $INTERACTIVE { docker container run -it --rm -p $PORTMAPPING -v ${pwd}:/usr/src/app $IMAGE }
    "" {
        "[ERROR]: No command specified"
        Print-Usage
    }
    default {
        "[ERROR]: $($command) not specified"
        Print-Usage
    }
}
