#!/usr/bin/env bash
# publish.sh — render the Quarto site and push it live to GitHub Pages.
#
# Usage:
#   ./publish.sh                 # uses a default commit message
#   ./publish.sh "your message"  # uses your own commit message
#
# What it does:
#   1. quarto render   → rebuilds the site into docs/
#   2. git add/commit  → stages everything (skips commit if nothing changed)
#   3. git push        → GitHub Pages serves the update in ~1 minute

set -euo pipefail

# Always run from the directory this script lives in.
cd "$(dirname "$0")"

MSG="${1:-update site}"

echo "→ Rendering site..."
quarto render

echo "→ Committing changes..."
git add -A
if git diff --cached --quiet; then
  echo "  Nothing changed — skipping commit and push."
  exit 0
fi
git commit -m "$MSG"

echo "→ Pushing to GitHub..."
git push

echo "✓ Done. enriqueescalante.com will update in ~1 minute."
