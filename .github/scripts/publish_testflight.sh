#!/bin/bash

set -eo pipefail

xcrun altool --upload-app -t ios -f build/"$NAME".ipa -u "melondesignltd@gmail.com" -p "xjju-efem-razc-bvdp" --verbose
