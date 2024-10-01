#!/bin/bash

SCHEME='CountryApp'
DESTINATION='platform:iOS Simulator, id:dvtdevice-DVTiOSDeviceSimulatorPlaceholder-iphonesimulator:placeholder, name:Any iOS Simulator Device'
PROJECT='CountryApp/CountryApp.xcodeproj'

xcodebuild test -project $PROJECT -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO'
