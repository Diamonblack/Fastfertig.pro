#!/bin/bash

# Fail fast
set -e

# --- CONFIGURATION ---
DOCKERFILE="Dockerfile"
INSIGHTS_PAGE="insights.html"
INDEX_PAGE="index.html"
NEW_INSIGHTS_CONTENT_FILE="new_insights_section.html"
INDEX_BACKUP_FILE="index.html.bak"

echo "--- Starting Website Refactor & Deployment Script ---"
cd /home/lexmellow/docker/portfolio

# --- STEP 1: Dockerfile anpassen ---
echo "[1/3] Checking and updating Dockerfile..."
if ! grep -q "COPY $INSIGHTS_PAGE" "$DOCKERFILE"; then
    # Insert 'COPY insights.html...' after 'COPY index.html...'
    sed -i "/COPY $INDEX_PAGE/a COPY $INSIGHTS_PAGE /usr/share/nginx/html/$INSIGHTS_PAGE" "$DOCKERFILE"
    echo "✅ Dockerfile updated."
else
    echo "ℹ️ Dockerfile already up-to-date."
fi

# --- STEP 2: index.html aktualisieren ---
echo "[2/3] Updating $INDEX_PAGE..."
echo "  - Backing up current $INDEX_PAGE to $INDEX_BACKUP_FILE"
cp "$INDEX_PAGE" "$INDEX_BACKUP_FILE"

# Use awk for robust multi-line replacement
awk -v new_content_file="$NEW_INSIGHTS_CONTENT_FILE" '
  BEGIN { printing = 1 }
  /<section id="insights">/ {
    system("cat " new_content_file);
    printing = 0;
  }
  # Match the specific closing tag of the insights section
  /<\/section>/ {
    if (printing == 0) {
      printing = 1;
      next;
    }
  }
  { if (printing == 1) print }
' "$INDEX_PAGE" > "$INDEX_PAGE.tmp" && mv "$INDEX_PAGE.tmp" "$INDEX_PAGE"

echo "✅ $INDEX_PAGE updated."

# --- STEP 3: Deployment ---
echo "[3/3] Deploying changes via Docker Compose..."
docker compose up -d --build --force-recreate
echo "🚀 Deployment initiated."

echo "--- Script finished successfully! ---"
