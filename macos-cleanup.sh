#!/bin/sh

open_folders() {
    local count=0
    local total=$#
    local failed=""
    for path in "$@"; do
        if open "$path" 2>/dev/null; then
            count=$((count + 1))
        else
            failed="$failed $path"
        fi
    done
    echo "Opened folders ($count/$total) for the selected section."
    echo ""
    if [ $count -lt $total ]; then
        echo "The following folders were not opened:$failed"
        echo ""
    fi
}

echo ""
echo "Select a section to open folders:"
echo "1. Application Support (5 folders)"
echo "2. Cashes (5 folders)"
echo "3. Containers (4 folders)"
echo "4. Crash Reports (2 folders)"
echo "5. Executables (1 folder)"
echo "6. Library (3 folders)"
echo "7. Login Items (2 folders)"
echo "8. Logs (3 folders)"
echo "9. Preferences (2 folders)"
echo "10. Shared (1 folder)"
echo "or"
echo "a. Open all sections (28 folders)"
echo "c. Close all Finder windows"
echo "q. Quit"
echo ""
read -p "Enter 1-10 or a/c/q: " choice

while true; do
    case $choice in
        1)
            echo "Opening folders for Application Support..."
            open_folders "/Library/Application Support" "$HOME" "$HOME/Library/Application Scripts" "$HOME/Library/Application Support" "$HOME/Library/HTTPStorages"
            ;;
        2)
            echo "Opening folders for Cashes..."
            open_folders "/private/var/db/receipts" "/private/var/folders" "$HOME/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments" "$HOME/Library/Caches" "$HOME/Library/Saved Application State"
            ;;
        3)
            echo "Opening folders for Containers..."
            open_folders "$HOME/Library/Containers" "$HOME/Library/Containers/com.apple.Safari/Data/Library/Safari/AppExtensions" "$HOME/Library/Containers/com.apple.Safari/Data/Library/WebKit/ContentExtensions" "$HOME/Library/Group Containers"
            ;;
        4)
            echo "Opening folders for Crash Reports..."
            open_folders "$HOME/Library/Application Support/CrashReporter" "$HOME/Library/Caches/com.plausiblelabs.crashreporter.data"
            ;;
        5)
            echo "Opening folders for Executables..."
            open_folders "/Applications"
            ;;
        6)
            echo "Opening folders for Library..."
            open_folders "/Library" "$HOME/Library" "$HOME/Library/WebKit"
            ;;
        7)
            echo "Opening folders for Login Items..."
            open_folders "/Library/LaunchDaemons" "$HOME/Library/LaunchAgents"
            ;;
        8)
            echo "Opening folders for Logs..."
            open_folders "/Library/Logs" "$HOME/Library/Logs" "$HOME/Library/Logs/DiagnosticReports"
            ;;
        9)
            echo "Opening folders for Preferences..."
            open_folders "/Library/Preferences" "$HOME/Library/Preferences"
            ;;
        10)
            echo "Opening folders for Shared..."
            open_folders "/Users/Shared"
            ;;
        a|A)
            echo "Opening all folders..."
            open_folders "/Library/Application Support" "$HOME" "$HOME/Library/Application Scripts" "$HOME/Library/Application Support" "$HOME/Library/HTTPStorages" \
                         "/private/var/db/receipts" "/private/var/folders" "$HOME/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments" "$HOME/Library/Caches" "$HOME/Library/Saved Application State" \
                         "$HOME/Library/Containers" "$HOME/Library/Containers/com.apple.Safari/Data/Library/Safari/AppExtensions" "$HOME/Library/Containers/com.apple.Safari/Data/Library/WebKit/ContentExtensions" "$HOME/Library/Group Containers" \
                         "$HOME/Library/Application Support/CrashReporter" "$HOME/Library/Caches/com.plausiblelabs.crashreporter.data" \
                         "/Applications" \
                         "/Library" "$HOME/Library" "$HOME/Library/WebKit" \
                         "/Library/LaunchDaemons" "$HOME/Library/LaunchAgents" \
                         "/Library/Logs" "$HOME/Library/Logs" "$HOME/Library/Logs/DiagnosticReports" \
                         "/Library/Preferences" "$HOME/Library/Preferences" \
                         "/Users/Shared"
            ;;
        q|Q)
            echo "Script terminated."
            echo ""
            exit 0
            ;;
        c|C)
            echo "Closing all Finder windows..."
            osascript -e 'tell application "Finder" to close every window'
            ;;
        *)
            echo "Error: enter only a number [1/2/3/4/5/6/7/8/9/10] or a letter [a/c/q]."
            echo ""
            ;;
    esac

    read -p "Enter 1-10 or a/c/q: " choice
done
