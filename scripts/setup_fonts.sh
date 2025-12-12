#!/bin/bash
# This script automates the process of self-hosting Google Fonts for GDPR compliance.

set -e # Exit immediately if a command exits with a non-zero status.

# --- CONFIGURATION ---
FONT_DIR="fonts"
CSS_FILE="$FONT_DIR/fonts.css"
# This URL is taken from the website's index.html
GOOGLE_FONTS_URL="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;800&family=JetBrains+Mono:wght@700&display=swap"
# We need a common browser User-Agent for Google to return the woff2 format.
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"

# --- SCRIPT ---

echo "--- Setting up local fonts for GDPR compliance ---"

# 1. Create the target directory
echo "[1/4] Creating directory: '$FONT_DIR'"
mkdir -p "$FONT_DIR"

# Temporary file for the CSS downloaded from Google
GOOGLE_CSS_TEMP="$FONT_DIR/google.css"

# 2. Download the master CSS file from Google Fonts
echo "[2/4] Downloading master CSS from Google Fonts..."
curl -A "$USER_AGENT" "$GOOGLE_FONTS_URL" -o "$GOOGLE_CSS_TEMP"

# 3. Download all .woff2 files referenced in the master CSS
echo "[3/4] Parsing and downloading all .woff2 font files..."
grep -o 'url(https://[^)]*.woff2)' "$GOOGLE_CSS_TEMP" | sed 's/url(//' | sed 's/)//' | wget --directory-prefix="$FONT_DIR" -i -

# 4. Generate the final, local fonts.css file
echo "[4/4] Generating local '$CSS_FILE'..."
# This sed command finds the full font URL and replaces it with just the font filename.
# Example: url(https://.../font.woff2) becomes url(font.woff2)
sed -E 's|url(https://.*/(.*\.woff2))|url(\1)|g' "$GOOGLE_CSS_TEMP" > "$CSS_FILE"

# Clean up the temporary file
rm "$GOOGLE_CSS_TEMP"

echo ""
echo "--- ✅ Success! ---"
echo "Created '$CSS_FILE' and downloaded all required fonts into the '$FONT_DIR' directory."
echo ""
echo "NEXT STEPS:"
echo "1. Add the following line to your Dockerfile to copy the fonts into the image:"
echo "   COPY fonts /usr/share/nginx/html/fonts"

echo "2. In index.html, replace the Google Fonts <link> tag with this one:"
echo "   <link rel=\"stylesheet\" href=\"fonts/fonts.css\">

echo "3. Re-build and deploy your container."
