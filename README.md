# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Palworld and run it.

**Server Name:** Palworld Docker  
**Password:** Docker  
**Admin Password:** adminDocker  

**Configuration:** The configuration is located at: .../Pal/Saved/Config/LinuxServer/PalWorldSettings.ini  

ATTENTION: First Startup can take very long since it downloads the gameserver files!

Update Notice: Simply restart the container if a newer version of the game is available.

You can also run multiple servers with only one SteamCMD directory!

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2394010 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2394010 |
| SRV_ADMIN_PWD | Your server admin password goes here | adminDocker |
| GAME_PARAMS | Enter your game parameters (for a community server put in the value 'EpicApp=PalServer' without quotes) | EpicApp=PalServer |
| GAME_PARAMS_EXTRA | Enter your Extra Game Parameters seperated with a space and - (eg: -No-useperfthreads -NoAsyncLoadingThread) | -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS |
| UPDATE_PUBLIC_IP | If set to 'true' the container will check on each container start if the Public IP is still valid (the container will try to grab your public IP on the first server start since the public IP is necessary to run a community server). | false |
| BACKUP | Set this value to 'true' to enable the automated backup function from the container, you find the Backups in '.../palworld/Backups/'. Set to 'false' to disable the backup function. | true |
| BACKUP_INTERVAL | The backup interval in minutes (ATTENTION: The first backup will be triggered after the set interval in this variable after the start/restart of the container) | 120 |
| BACKUPS_TO_KEEP | Number of backups to keep (by default set to 12 to keep the last backups of the last 24 hours) | 12 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Palworld `
    -p 8211:8211/udp -p 25575:25575 `
    -e "GAME_ID=2394010" `
    -e "UPDATE_PUBLIC_IP=false" `
    -e "GAME_PARAMS=EpicApp=PalServer" `
    -e "GAME_PARAMS_EXTRA=-No-useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS" `
    -e "BACKUP=true" `
    -e "BACKUP_INTERVAL=120" `
    -e "BACKUPS_TO_KEEP=12" `
    -e "UID=99" `
    -e "GID=100" `
    palworld
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/