```asciidoc
= You can only pick one of these and they are required for building
-desktopapp (makes it build the desktop app)
-webapp (makes it build the web app)
-multiapp (makes it build both)

= These are optional and you can pick which ones you want
-basepath "hello" (customizes the base path for only that run)
-yarn (makes it do yarn install first for the app you specified)
-yarnall (makes it do yarn install for all the apps)
-gitpull (runs git pull)
-gitfork (merges changes from upstream)
-lesslogs (reduce the amount of logging the script does)

= Examples
.\saladbuilder.ps1 -desktopapp -yarn
This will make Salad Builder run yarn install, then build the desktop app.

.\saladbuilder.ps1 -desktopapp
This will make Salad Builder build the desktop app, without yarn.

.\saladbuilder.ps1 -desktopapp -yarn -basepath "C:/Users/Vukky/Salad/packages"
This will make Salad Builder override the default base path and use "C:/Users/Vukky/Salad/packages" instead.
In that folder, it will do the usual steps: run yarn install, then build the desktop app.
```