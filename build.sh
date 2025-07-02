# summary: A build.sh that bootstraps the Flutter SDK on Vercel, then builds your Flutter Web app.
#!/usr/bin/env bash
set -e

# 1. Clone Flutter SDK if not already cached
FLUTTER_DIR="$PWD/flutter"
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Cloning Flutter SDK (stable channel)..."
  git clone https://github.com/flutter/flutter.git --depth 1 --branch stable "$FLUTTER_DIR"
fi

# 2. Add Flutter to PATH
export PATH="$FLUTTER_DIR/bin:$PATH"

# 3. Precache web artifacts (optional but speeds up first build)
flutter precache --web

# 4. Get packages and build for web
flutter pub get
flutter build web --release
