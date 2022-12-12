# [reference of key mapping](https://developer.apple.com/library/archive/technotes/tn2450/_index.html#//apple_ref/doc/uid/DTS40017618-CH1-KEY_TABLE_USAGES)
# 1. run below script. ex) sh ./mac/toggleHanEng.sh
    # this script change 'right command key to' to 'F18'
# 2. change system input source(setting > keyboard > shortcut > input source). Previous Input Source -> F18

# default key of toggleHanEng -> disable in input source(setting > keyboard > input source)

mkdir -p /Users/Shared/bin
echo '''#!/bin/sh\nhidutil property --set '\'{\"UserKeyMapping\":\[\{\"HIDKeyboardModifierMappingSrc\":0x7000000e7,\"HIDKeyboardModifierMappingDst\":0x70000006d\}\]\}\''''' > /Users/Shared/bin/userkeymapping
chmod 755 /Users/Shared/bin/userkeymapping
sudo cat<<: >/Users/Shared/bin/userkeymapping.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>userkeymapping</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/Shared/bin/userkeymapping</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
:
sudo mv /Users/Shared/bin/userkeymapping.plist /Library/LaunchAgents/userkeymapping.plist
sudo chown root /Library/LaunchAgents/userkeymapping.plist
sudo launchctl load /Library/LaunchAgents/userkeymapping.plist
