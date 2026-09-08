# Setup instructions
- Build the container with `docker build -t valheim-server:0 .`
- Copy default.env to prod.env and configure as needed
- Start the container with the `run.sh` script
- Note that tag is set to 0 and staticly set in the run script

# Environment variables
- Name of the server `VALHEIM_SERVER='SomeName'`
- Name of the world `VALHEIM_WORLD='World'`
- Port used in the container `VALHEIM_PORT=2456`
- Setup a password `VALHEIM_PASS=SomePassWord`
- Number of world backups to keep `VALHEIM_BACKUPS=5`
- World backup interval `VALHEIM_SAVEINTERVAL=1800`
- Allow cross platform connections `VALHEIM_CROSSPLAY=1` else 0 for not
- Make server show in public list `VALHEIM_PUBLIC=1` else 0 for not

The following are difficulty settings. The Pipe'd string shows all available options. You must pick 1 or not include the line in your prod.env file.
- Pick a difficulty preset: `VALHEIM_PRESET='normal|casual|easy|hard|hardcore|immersive|hammer'` # pick 1 or comment
- `VALHEIM_COMBAT='veryeasy|easy|hard|veryhard'` # pick 1 or comment
- `VALHEIM_DEATHPENALTY='casual|veryeasy|easy|hard|hardcore'` # pick 1 or comment
- `VALHEIM_RESOURCES='muchless|less|more|muchmore|most'` # pick 1 or comment
- `VALHEIM_RAIDS='none|muchless|less|more|muchmore'` # pick 1 or comment
- `VALHEIM_PORTALS='casual|hard|veryhard'` # pick 1 or comment

# Volume
Create a volume to preserve your world files and other server files such as `bannedlist.txt` and `adminlist.txt`

`-v valheim-world:/home/steam/.config/unity3d/IronGate/Valheim`

After creating the volume copy the files/directory from `blank-volume` into this new volume. If you skip this step the container will fail to generate the files due to permissions issues.