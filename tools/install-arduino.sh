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
# remove code and libraries not needed/wanted for a small framework
#
rm -rf "$AR_COMPS/arduino/docs"
rm -rf "$AR_COMPS/arduino/idf_component_examples"
rm -rf "$AR_COMPS/arduino/tests"
rm -rf "$AR_COMPS/arduino/libraries/RainMaker"
rm -rf "$AR_COMPS/arduino/libraries/Insights"
rm -rf "$AR_COMPS/arduino/libraries/ESP32"
rm -rf "$AR_COMPS/arduino/libraries/ESP_SR"
rm -rf "$AR_COMPS/arduino/libraries/TFLiteMicro"
rm -rf "$AR_COMPS/arduino/libraries/OpenThread"

#
# A modified Arduino component file is needed. Not wanted components removed. Else compile fails
#
cp -f "$AR_PATCHES/arduino_component.yml" "$AR_COMPS//arduino/idf_component.yml"
cp -f "$AR_PATCHES/arduino_CMakeLists.txt" "$AR_COMPS//arduino/CMakeLists.txt"