download-monitor
================

Fixes the mess in your downloads folder.

# Usage

1. Configure the ExecStart line of `download-monitor.service` according to the path of your download folder.

Mine is: `ExecStart=/home/paolo/download-monitor/monitor.sh "/home/paolo/downloads"`

2. Run the service under your control with `systemctl --user start download-monitor.service`

3. (Optional) Enable the service on user login with `systemctl --user enable download-monitor.service`

# How it works

It monitors your downloads folder waiting for new files. When a new file is detected it analizes its type and it will move this one to the right folder.

If you want to personalize the subfolder you must add a prefix follwed by an underscore to the file name.

Eg:

Download the image: cat_funny.jpeg to your download folder.

The service will move the file to the folder `download/image/cat/` renaming it to `funny.jpeg`, thus the new location is `download/image/cat/funny.jpeg`

If you don't add a prefix, the file will be moved to a `misc` subfolder.
