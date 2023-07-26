# VodRecovery
* The purpose of this script is to obtain videos or clips that are either marked as "sub-only" or have been deleted on Twitch. 

# About
* Developed by: Shishkebaboo (formerly ItIckeYd)
* Initial release: May 3rd, 2022
* The script leverages logic from the [TwitchRecover](https://github.com/TwitchRecover/TwitchRecover) repository developed by [Daylam Tayari](https://github.com/daylamtayari)

# Features
* Supports both manual and website vod recovery
* Can recover vods individually or in bulk using a CSV downloaded from [Sullygnome](https://sullygnome.com/)
* Can recover clips manually or in bulk using a CSV from [Sullygnome](https://sullygnome.com/)
* Supports downloading M3U8 links/files, with the ability to specify start/end timestamps for trimmed vods using [FFmpeg](https://ffmpeg.org/download.html)
* Compatible with [TwitchTracker](https://twitchtracker.com/), [Sullygnome](https://sullygnome.com/), and [Streamscharts](https://streamscharts.com/)
* Uses UTC timezone as default for recovering vods
* Notifies if vod is older than 60 days (due to Twitch's deletion process)

# Installation
## Windows
* Download/install - [Python](https://www.python.org/downloads/)
* Clone the repository
* Navigate to the cloned directory
* Install required packages with `pip install -r requirements.txt` (run in terminal)
* If you make changes to installed packages locally, you can overwrite the requirements.txt file with `pipreqs <path_of_project> --force`
* Run the script

### Pin VodRecovery to taskbar
1) Right-click on your Python script file and select `Create shortcut`.
2) Right-click on the new shortcut file and select `Properties`.
3) In the `Target` field, add `python ` before the path of the script file. For example, if your script is located at `C:\PythonProjects\RecoverVod.py`, your target should be `python C:\PythonProjects\RecoverVod.py`.
4) Click `OK` to save the changes.
5) Right-click on the shortcut file again and select `Pin to taskbar` to add the script to your taskbar.

## Expected Script Output

```
WELCOME TO VOD RECOVERY

1) Recover Vod
2) Recover Clips
3) Unmute an M3U8 file
4) Check Segment Availability
5) Generate M3U8 file (ONLY includes valid segments)
6) Download M3U8 (.MP4 extension)
7) Exit

Please choose an option:
```

## Expected FFmpeg Ouput
* Run the `ffmpeg` command in Command Prompt

![ffmpeg_preview](https://user-images.githubusercontent.com/118132878/216841020-617b9807-3a4c-4f03-856e-854d91306880.png)

# Configuration File
* The configuration file can be used to limit the amount of user input when using the script. The following options are among the most popular to change for users:
 1. ```UNMUTE_VOD```
 2. ```CHECK_SEGMENTS```
 3. ```DOWNLOAD_CLIPS```
 4. ```REMOVE_LOG_FILE```
 5. ```DEFAULT_DIRECTORY```
 6. ```DOWNLOAD_DIRECTORY```
 7. ```MAX_REQUEST_SIZE```

### Default Configuration
![config_file_vodrecover](https://user-images.githubusercontent.com/118132878/220527660-54a2f47c-20cf-4c2d-b4d1-7c9866835ad4.png)

## Docker
### Building the image
Use `--build-arg FFMPEG=1` if you want support for downloading M3U8s/VODs as MP4s

`docker build --build-arg FFMPEG=0 -t vodrecovery https://github.com/Shishkebaboo/VodRecovery.git`
#### Upgrading the image
`docker build --pull --no-cache --build-arg FFMPEG=0 -t vodrecovery https://github.com/Shishkebaboo/VodRecovery.git`

### Running the image
```sh
docker run --replace -d \
  --name vodrecovery \
  -v $PWD/vodrecovery_config.json:/app/config/vodrecovery_config.json \ #optional: mount custom config
  -v $PWD/vods:/vods \ #mount data directory
  -p 7681:7681 \
  --restart always \
  vodrecovery
```
A web shell will be accessible on port 7681 (e.g. [http://127.0.0.1:7681](http://127.0.0.1:7681)) for easy remote access.

Especially useful when combined with a static file server that serves the `$PWD/vods` directory for remote consumption.

# Optional IDEs
* [PyCharm Community Edition](https://www.jetbrains.com/pycharm/download/) (Recommended)
* [Visual Studio Code](https://code.visualstudio.com/download)

# Additional Notes
* Provide at least one example when creating an issue
* Make sure that the vod requests are within [Twitch's vod retention policy](https://help.twitch.tv/s/article/video-on-demand). Any vod requests that exceed this policy will be ignored
* The script was developed for the Windows operating system. If you are using a different operating system, such as Linux, unexpected results may occur when running the script

# Support the Project
* Donations are much appreciated but are not expected. If you would like to contribute, you can do so via PayPal using the following link: [PayPal](https://paypal.me/VodRecovery)

# Latest Release
* [Stable Release - 1.0.2.0](https://github.com/Shishkebaboo/VodRecovery/releases/tag/vodrecovery-1.0.2.0)

