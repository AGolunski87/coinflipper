# build.sh
#!/usr/bin/env bash
set -e

# 1. Fetch Dart/Flutter packages
flutter pub get

# 2. Build the web app in release mode
flutter build web --release

# (Vercel will then pick up build/web as the static output)
