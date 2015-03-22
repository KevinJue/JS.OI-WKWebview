#!/bin/sh

xctool \
    -project js.oi.xcodeproj \
    -scheme js.oi \
    -sdk iphonesimulator \
    build \
    clean test -test-sdk iphonesimulator -resetSimulator -freshInstall
