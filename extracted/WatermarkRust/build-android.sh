#!/usr/bin/env bash
# Builds the debug APK. Needs internet ONCE (crates, npm, Gradle, SDK); the app itself is offline.
# Prereqs: Rust (rustup), Node 18+, JDK 17, Android SDK + NDK (ANDROID_HOME, NDK_HOME set).
set -euo pipefail
cd "$(dirname "$0")"
rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
npm install
npm run vendor                       # copies pdf-lib / PDF.js 3.11.174 + worker into src/vendor
npx tauri icon app-icon.png          # generates all icon sizes incl. Android adaptive icons
[ -d src-tauri/gen/android ] || npx tauri android init
npx tauri android build --debug --apk
find src-tauri/gen/android -name "*.apk" -print
