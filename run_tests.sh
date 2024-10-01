#!/bin/bash

SCHEME='CountryApp'
DESTINATION='platform=iOS Simulator,OS=17.2,name=iPhone 15'
PROJECT='CountryApp/CountryApp.xcodeproj'

xcodebuild test -project $PROJECT -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO'
