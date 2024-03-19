#/bin/bash

source ./tools/config.sh

if ! [ -x "$(command -v $SED)" ]; then
  	echo "ERROR: $SED is not installed! Please install $SED first."
  	exit 1
fi

#
# CLONE ESP-IDF
#
if [ "$IDF_TAG" ] || [ "$IDF_COMMIT" ]; then
        if [ ! -d "$IDF_PATH" ]; then
            # full clone needed to check out tag or commit
	    echo "ESP-IDF is not installed! Installing with full clone from $IDF_REPO_URL branch $IDF_BRANCH"
            git clone $IDF_REPO_URL -b $IDF_BRANCH
	    idf_was_installed="1"
        else
            # update local clone
	    echo "ESP-IDF is installed, updating..."
	    cd $IDF_PATH
            git pull
            git reset --hard $IDF_BRANCH
            git submodule update
	    # -ff is for cleaning untracked files as well as submodules
            git clean -ffdx
            cd -
	    idf_was_installed="1"
        fi
fi

if [ ! -d "$IDF_PATH" ]; then
    # for using a branch we need no full clone
    echo "ESP-IDF is not installed! Installing branch $IDF_BRANCH from $IDF_REPO_URL"
    git clone -b $IDF_BRANCH --recursive --depth 1 --shallow-submodule $IDF_REPO_URL
    idf_was_installed="1"
else
    # update existing branch
    echo "ESP-IDF is already installed, updating branch $IDF_BRANCH"
    cd $IDF_PATH
    git pull
    git reset --hard $IDF_BRANCH
    git submodule update --depth 1
    # -ff is for cleaning untracked files as well as submodules
    git clean -ffdx
    cd -
    idf_was_installed="1"
fi

if [ "$IDF_TAG" ]; then
    git -C "$IDF_PATH" checkout "tags/$IDF_TAG"
    idf_was_installed="1"
elif [ "$IDF_COMMIT" ]; then
    git -C "$IDF_PATH" checkout "$IDF_COMMIT"
    commit_predefined="1"
fi

#
# UPDATE ESP-IDF TOOLS AND MODULES
#

if [ ! -x $idf_was_installed ] || [ ! -x $commit_predefined ]; then
        git submodule update --recursive
	$IDF_PATH/install.sh

	# Temporarily patch the ESP32-S2 I2C LL driver to keep the clock source
	cd $IDF_PATH
	patch -p1 -N -i ../patches/esp32s2_i2c_ll_master_init.diff
	cd -

        # Get the exact IDF version from file "version.txt"
	cd $IDF_PATH
	export IDF_VERSION=$(<version.txt)
        echo "IDF version: $IDF_VERSION"
	cd -  
fi

#
# SETUP ESP-IDF ENV
#

source $IDF_PATH/export.sh

#
# SETUP ARDUINO DEPLOY
#

if [ "$GITHUB_EVENT_NAME" == "schedule" ] || [ "$GITHUB_EVENT_NAME" == "repository_dispatch" -a "$GITHUB_EVENT_ACTION" == "deploy" ]; then
	# format new branch name and pr title
	if [ -x $commit_predefined ]; then #commit was not specified at build time
		AR_NEW_BRANCH_NAME="idf-$IDF_BRANCH"
		AR_NEW_COMMIT_MESSAGE="IDF $IDF_BRANCH $IDF_COMMIT"
		AR_NEW_PR_TITLE="IDF $IDF_BRANCH"
	else
		AR_NEW_BRANCH_NAME="idf-$IDF_COMMIT"
		AR_NEW_COMMIT_MESSAGE="IDF $IDF_COMMIT"
		AR_NEW_PR_TITLE="$AR_NEW_COMMIT_MESSAGE"
	fi
	LIBS_VERSION="idf-"${IDF_BRANCH//\//_}"-$IDF_COMMIT"

	AR_HAS_COMMIT=`git_commit_exists "$AR_COMPS/arduino" "$AR_NEW_COMMIT_MESSAGE"`
	AR_HAS_BRANCH=`git_branch_exists "$AR_COMPS/arduino" "$AR_NEW_BRANCH_NAME"`
	AR_HAS_PR=`git_pr_exists "$AR_NEW_BRANCH_NAME"`

	LIBS_HAS_COMMIT=`git_commit_exists "$IDF_LIBS_DIR" "$AR_NEW_COMMIT_MESSAGE"`
	LIBS_HAS_BRANCH=`git_branch_exists "$IDF_LIBS_DIR" "$AR_NEW_BRANCH_NAME"`

	if [ "$LIBS_HAS_COMMIT" == "1" ]; then
		echo "Commit '$AR_NEW_COMMIT_MESSAGE' Already Exists in esp32-arduino-libs"
	fi

	if [ "$AR_HAS_COMMIT" == "1" ]; then
		echo "Commit '$AR_NEW_COMMIT_MESSAGE' Already Exists in arduino-esp32"
	fi

	if [ "$LIBS_HAS_COMMIT" == "1" ] && [ "$AR_HAS_COMMIT" == "1" ]; then
		exit 0
	fi

	export AR_NEW_BRANCH_NAME
	export AR_NEW_COMMIT_MESSAGE
	export AR_NEW_PR_TITLE

	export AR_HAS_COMMIT
	export AR_HAS_BRANCH
	export AR_HAS_PR

	export LIBS_VERSION
	export LIBS_HAS_COMMIT
	export LIBS_HAS_BRANCH
fi
