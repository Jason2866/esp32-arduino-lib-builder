#!/bin/bash


if [ -z $IDF_PATH ]; then
	export IDF_PATH="$PWD/esp-idf"
fi

# The ESP32 IDF repository
IDF_REPO_URL="https://github.com/tasmota/esp-idf.git"

# The IDF branch to use
if [ -z $IDF_BRANCH ]; then
	IDF_BRANCH="lwip_fs"
fi

if [ -z $AR_PR_TARGET_BRANCH ]; then
	AR_PR_TARGET_BRANCH="master"
fi

# IDF commit to use
#IDF_COMMIT="2549b9fe369005664ce817c4d290a3132177eb8d"

if [ -z $IDF_TARGET ]; then
	if [ -f sdkconfig ]; then
		IDF_TARGET=`cat sdkconfig | grep CONFIG_IDF_TARGET= | cut -d'"' -f2`
		if [ "$IDF_TARGET" = "" ]; then
			IDF_TARGET="esp32"
		fi
	else
		IDF_TARGET="esp32"
	fi
fi

# Owner of the target ESP32 Arduino repository
AR_USER="tasmota"

# The full name of the repository
AR_REPO="$AR_USER/arduino-esp32"

# Arduino branch to use
AR_BRANCH="release/v2.x"

AR_REPO_URL="https://github.com/$AR_REPO.git"
IDF_LIBS_REPO_URL="https://github.com/tasmota/esp32-arduino-libs.git"
if [ -n $GITHUB_TOKEN ]; then
	AR_REPO_URL="https://$GITHUB_TOKEN@github.com/$AR_REPO.git"
	IDF_LIBS_REPO_URL="https://$GITHUB_TOKEN@github.com/tasmota/esp32-arduino-libs.git"
fi

AR_ROOT="$PWD"
AR_COMPS="$AR_ROOT/components"
AR_OUT="$AR_ROOT/out"
AR_TOOLS="$AR_OUT/tools"
AR_PLATFORM_TXT="$AR_OUT/platform.txt"
AR_GEN_PART_PY="$AR_TOOLS/gen_esp32part.py"
AR_SDK="$AR_TOOLS/esp32-arduino-libs/$IDF_TARGET"
PIO_SDK="FRAMEWORK_DIR, \"tools\", \"sdk\", \"$IDF_TARGET\""
TOOLS_JSON_OUT="$AR_TOOLS/esp32-arduino-libs"
IDF_LIBS_DIR="$AR_ROOT/../esp32-arduino-libs"

if [ "$IDF_COMMIT" ]; then
    echo "Using specific commit $IDF_COMMIT for IDF"
else
    IDF_COMMIT=$(git -C "$IDF_PATH" rev-parse --short HEAD || echo "")
fi

AR_COMMIT=$(git -C "$AR_COMPS/arduino" rev-parse --short HEAD || echo "")

rm -rf release-info.txt
echo "Framework built from Tasmota IDF branch $IDF_BRANCH commit $IDF_COMMIT and $AR_REPO branch $AR_BRANCH commit $AR_COMMIT" >> release-info.txt

function get_os(){
  	OSBITS=`arch`
  	if [[ "$OSTYPE" == "linux"* ]]; then
        if [[ "$OSBITS" == "i686" ]]; then
        	echo "linux32"
        elif [[ "$OSBITS" == "x86_64" ]]; then
        	echo "linux64"
        elif [[ "$OSBITS" == "armv7l" ]]; then
        	echo "linux-armel"
        else
        	echo "unknown"
	    	return 1
        fi
	elif [[ "$OSTYPE" == "darwin"* ]]; then
	    echo "macos"
	elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
	    echo "win32"
	else
	    echo "$OSTYPE"
	    return 1
	fi
	return 0
}

AR_OS=`get_os`

export SED="sed"
export SSTAT="stat -c %s"

if [[ "$AR_OS" == "macos" ]]; then
	if ! [ -x "$(command -v gsed)" ]; then
		echo "ERROR: gsed is not installed! Please install gsed first. ex. brew install gsed"
		exit 1
	fi
	if ! [ -x "$(command -v gawk)" ]; then
		echo "ERROR: gawk is not installed! Please install gawk first. ex. brew install gawk"
		exit 1
	fi
	export SED="gsed"
	export SSTAT="stat -f %z"
fi

function git_commit_exists(){ #git_commit_exists <repo-path> <commit-message>
	local repo_path="$1"
	local commit_message="$2"
	local commits_found=`git -C "$repo_path" log --all --grep="$commit_message" | grep commit`
	if [ -n "$commits_found" ]; then echo 1; else echo 0; fi
}

function git_branch_exists(){ # git_branch_exists <repo-path> <branch-name>
	local repo_path="$1"
	local branch_name="$2"
	local branch_found=`git -C "$repo_path" ls-remote --heads origin "$branch_name"`
	if [ -n "$branch_found" ]; then echo 1; else echo 0; fi
}
