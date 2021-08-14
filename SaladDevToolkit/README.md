# Salad Dev Toolkit

## Usage

### Required for building
*You may only pick one of these.*

`-desktopapp` (builds the desktop app)

`-webapp` (builds the web app)

`-multiapp` (builds the web app and the desktop app - may not work)


### Optional
`-basepath` "hello" (customizes the base path for only that run)

`-yarn` (runs yarn install first [for the app you specified](#required-for-building))

`-yarnall` (runs yarn install for all the apps)

`-gitpull` (runs git pull)

`-gitfork` (merges changes from upstream)

`-lesslogs` (reduce the amount of logging the script does)

### Examples
`.\saladdevtoolkit.ps1 -desktopapp -yarn`

This will make Salad Dev Toolkit run yarn install, then build the desktop app.

`.\saladdevtoolkit.ps1 -desktopapp`

This will make Salad Dev Toolkit build the desktop app, without yarn install.

`.\saladdevtoolkit.ps1 -desktopapp -yarn -basepath "C:/Users/Vukky/Salad/packages"`

This will make Salad Dev Toolkit override the default base path and use `C:/Users/Vukky/Salad/packages` instead.
In that folder, it will do the usual steps: run yarn install, then build the desktop app.
