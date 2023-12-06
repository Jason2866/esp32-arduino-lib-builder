#/bin/bash

source ./tools/config.sh

#
# CLONE/UPDATE ARDUINO
#
if [ "$AR_BRANCH" ]; then
	echo "Installing Arduino from branch '$AR_BRANCH'"
    if [ ! -d "$AR_COMPS/arduino" ]; then
    	# for using a branch we need no full clone
        git clone -b "$AR_BRANCH" --recursive --depth 1 --shallow-submodule $AR_REPO_URL "$AR_COMPS/arduino"
    else
        # update existing branch
	cd "$AR_COMPS/arduino"
        git pull
        git reset --hard $AR_BRANCH
	# -ff is for cleaning untracked files as well as submodules
        git clean -ffdx
        cd -
    fi
fi

if [ ! -d "$AR_COMPS/arduino" ]; then
        # we need a full clone since no branch was set
	echo "Full cloning of ESP32 Arduino repo '$AR_REPO_URL'"
	git clone $AR_REPO_URL "$AR_COMPS/arduino"
else
    if [ "$AR_BRANCH" ]; then
	echo "ESP32 Arduino is up to date"
    else
	# update existing branch
	echo "Updating ESP32 Arduino"
	cd "$AR_COMPS/arduino"
        git pull
	# -ff is for cleaning untracked files as well as submodules
        git clean -ffdx
        cd -
	fi
fi

if [ -z $AR_BRANCH ]; then
	if [ -z $GITHUB_HEAD_REF ]; then
		current_branch=`git branch --show-current`
	else
		current_branch="$GITHUB_HEAD_REF"
	fi
	echo "Current Branch: $current_branch"
	if [[ "$current_branch" != "master" && `git_branch_exists "$AR_COMPS/arduino" "$current_branch"` == "1" ]]; then
		export AR_BRANCH="$current_branch"
	else
		if [ "$IDF_TAG" ]; then #tag was specified at build time
			AR_BRANCH_NAME="idf-$IDF_TAG"
		elif [ "$IDF_COMMIT" ]; then #commit was specified at build time
			AR_BRANCH_NAME="idf-$IDF_COMMIT"
		else
			AR_BRANCH_NAME="idf-$IDF_BRANCH"
		fi
		has_ar_branch=`git_branch_exists "$AR_COMPS/arduino" "$AR_BRANCH_NAME"`
		if [ "$has_ar_branch" == "1" ]; then
			export AR_BRANCH="$AR_BRANCH_NAME"
		else
			has_ar_branch=`git_branch_exists "$AR_COMPS/arduino" "$AR_PR_TARGET_BRANCH"`
			if [ "$has_ar_branch" == "1" ]; then
				export AR_BRANCH="$AR_PR_TARGET_BRANCH"
			fi
		fi
	fi
fi

if [ $? -ne 0 ]; then exit 1; fi

#
# remove libraries not needed for Tasmota
#
rm -rf "$AR_COMPS/arduino/libraries/RainMaker"
rm -rf "$AR_COMPS/arduino/libraries/Insights"
rm -rf "$AR_COMPS/arduino/libraries/ESP_I2S"
rm -rf "$AR_COMPS/arduino/libraries/BLE"
rm -rf "$AR_COMPS/arduino/libraries/SimpleBLE"
rm -rf "$AR_COMPS/arduino/libraries/BluetoothSerial"
rm -rf "$AR_COMPS/arduino/libraries/WiFiProv"
rm -rf "$AR_COMPS/arduino/libraries/WiFiClientSecure"
rm -rf "$AR_COMPS/arduino/libraries/ESP32"
rm -rf "$AR_COMPS/arduino/libraries/ESP_SR"
rm -rf "$AR_COMPS/arduino/libraries/TFLiteMicro"

#
# CLONE/UPDATE ESP32-ARDUINO-LIBS
#
#if [ ! -d "$IDF_LIBS_DIR" ]; then
#	echo "Cloning esp32-arduino-libs..."
#	git clone "$AR_LIBS_REPO_URL" "$IDF_LIBS_DIR"
#else
#	echo "Updating esp32-arduino-libs..."
#	git -C "$IDF_LIBS_DIR" fetch && \
#	git -C "$IDF_LIBS_DIR" pull --ff-only
#fi
#if [ $? -ne 0 ]; then exit 1; fi
