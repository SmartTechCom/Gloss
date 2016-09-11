#！/bin/bash

## 获取当前脚步所在根目录
CURRENT_DIR=`pwd`
dirname $0|grep "^/" >/dev/null
if [ $? -eq 0 ];then
CURRENT_DIR=`dirname $0`
else
dirname $0|grep "^\." >/dev/null
retval=$?
if [ $retval -eq 0 ];then
CURRENT_DIR=`dirname $0|sed "s#^.#$CURRENT_DIR#"`
else
CURRENT_DIR=`dirname $0|sed "s#^#$CURRENT_DIR/#"`
fi
fi
echo $CURRENT_DIR

cd ${CURRENT_DIR}/

# Sets the target folders and the final framework product.
FMK_NAME="Gloss"

# Install dir will be the final output to the framework.
# The following line create it in the root folder of the current project.
INSTALL_DIR=${CURRENT_DIR}/Products/${FMK_NAME}.framework

# Working dir will be deleted after the framework creation.
WRK_DIR=build
RE_DEVICE_DIR=${WRK_DIR}/Release-iphoneos
DEVICE_DIR=${RE_DEVICE_DIR}/${FMK_NAME}.framework
RE_SIMULATOR_DIR=${WRK_DIR}/Release-iphonesimulator
SIMULATOR_DIR=${RE_SIMULATOR_DIR}/${FMK_NAME}.framework

DEVICE_POD_BUILD_DIR="./Pods/build/Release-iphoneos"
SIMULATOR_POD_BUILD_DIR="./Pods/build/Release-iphonesimulator"

# -configuration ${CONFIGURATION}
# Clean and Building both architectures.
xcodebuild -configuration "Release" -project "${FMK_NAME}.xcodeproj" -target "${FMK_NAME}" -sdk iphoneos clean build CONFIGURATION_BUILD_DIR="${RE_DEVICE_DIR}"
xcodebuild -configuration "Release" -project "${FMK_NAME}.xcodeproj" -target "${FMK_NAME}" -sdk iphonesimulator clean build CONFIGURATION_BUILD_DIR="${RE_SIMULATOR_DIR}"

# Cleaning the oldest.
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi

mkdir -p "${INSTALL_DIR}"

cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"

# Uses the Lipo Tool to merge both binary files (i386 + armv6/armv7/armv7s/arm64) into one Universal final product.
lipo -create "${DEVICE_DIR}/${FMK_NAME}" "${SIMULATOR_DIR}/${FMK_NAME}" -output "${INSTALL_DIR}/${FMK_NAME}"
lipo -remove i386 "${INSTALL_DIR}/${FMK_NAME}" -output "${INSTALL_DIR}/${FMK_NAME}"
rm -r "${WRK_DIR}"