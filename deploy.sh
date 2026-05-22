#!/bin/bash
# deploy.sh — push updates to David's Cloudflare Pages site
# Usage: ./deploy.sh "optional commit message"

set -e
cd "$(dirname "$0")"

MSG="${1:-update site}"

echo "📦 Committing to git..."
git add -A
git commit -m "$MSG" 2>/dev/null || echo "nothing new to commit"
git push origin main 2>/dev/null || true

echo "🚀 Deploying to Cloudflare Pages..."
npx wrangler@latest pages deploy .deploy \
  --project-name david-roberts-photography \
  --branch main \
  --commit-dirty=true

echo "✅ Done — https://david-roberts-photography.pages.dev"
