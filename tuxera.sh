echo "Stopping Tuxera..."
pkill -f "tuxera" 2>/dev/null || true

echo "Removing app..."
sudo rm -rf /Applications/Tuxera\ NTFS.app

echo "Cleaning data..."
rm -rf ~/Library/Preferences/*tuxera* 2>/dev/null || true
rm -rf ~/Library/Application\ Support/Tuxera\ NTFS/
sudo rm -rf /Library/Preferences/*tuxera* 2>/dev/null || true
sudo rm -rf /Library/Application\ Support/Tuxera\ NTFS/

security delete-generic-password -l "Tuxera NTFS" 2>/dev/null
security delete-generic-password -s "Tuxera NTFS" 2>/dev/null

killall cfprefsd 2>/dev/null || true

echo "Mounting DMG..."
hdiutil attach ~/Downloads/tuxerantfs_26.dmg

sleep 2

MOUNT=$(ls /Volumes | grep -i tuxera | head -n 1)
FULL_MOUNT="/Volumes/$MOUNT"

echo "Mounted at: $FULL_MOUNT"

INSTALLER=$(find "$FULL_MOUNT" -name "*Install*.app" | head -n 1)
echo "Installer: $INSTALLER"

echo "Running installer..."
open "$INSTALLER"

echo "Done - now install manually in popup"
