# trickplayCleanup
Script to programatically delete extra trickplay folders created by Jellyfin

Runs as a bach script in a linux environment.
No real clever tricks are used, but this was developed with debian-like environments in mind.

I am not a coder or developer by trade or experience, please review this script before executing on your own system.

**THIS SCRIPT USES AN rm -rf COMMAND THAT ACCEPTS ANY ARBITRARY INPUT. TEST ON A BACKED UP DIRECTORY BEFORE ATTEMPTING TO USE THIS TO CLEAN YOUR LIBRARY**

## Using this script
1. Download the script to your machine, and make it executable
2. run it with ./trickplayCleanup /Your/Media/Directory
3. Watch the console to see what it is doing, and if you like the results
4. If there are no issues, edit the script, and uncomment the rm -rf line to have the script delete files.

By default, the portion of this code repsonsible for deleting files is commented out. All of the scripts actions are logged in the console, and can be reviewed from there.
This script **Should** be able to start at the top of your media library and recursively check all folders inside.

## Expected Logic

# Jellyfin
- Jellyfin saves related items, specifically trickplays, in the same directory as the media files
- Where media is named yourStandardizedfileName.extension, trickplay folder should be named yourStandardizedFileName.trickplay (This is normal Jellyfin behavior)
- names of the contents of the trickplay images in the folder are irrelevant

## Program Logic
- where a folder is encountered, check to see if it ends in .trickplay
  - If it does not, continue
  - If it does, compare folder to a list of files with known extensions.
    - If fileName.trickplay matches at least one fileName.extension in the directory, skip.
    - If it does not match, mark for deletion
- Delete folders and files marked for deletion
