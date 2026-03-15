#!/usr/bin/env bash
set -euo pipefail

site_dir="${1:-_site}"

require_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    echo "Missing expected file: $path" >&2
    exit 1
  fi
}

require_absent() {
  local path="$1"
  if [[ -e "$path" ]]; then
    echo "Unexpected published file: $path" >&2
    exit 1
  fi
}

require_contains() {
  local path="$1"
  local pattern="$2"
  if ! grep -q "$pattern" "$path"; then
    echo "Expected pattern '$pattern' not found in $path" >&2
    exit 1
  fi
}

require_file "$site_dir/index.html"
require_file "$site_dir/sitemap.xml"
require_file "$site_dir/feed.xml"
require_file "$site_dir/favicon.png"
require_file "$site_dir/assets/dist-styles.css"
require_file "$site_dir/liquid-glass-css.html"
require_file "$site_dir/liquid-glass-web-development.html"
require_file "$site_dir/development/flutter-liquid-glass-demo/index.html"
require_file "$site_dir/design/framer-apple-liquid-button/index.html"
require_file "$site_dir/privacy-policy/index.html"
require_file "$site_dir/terms-of-use/index.html"

require_contains "$site_dir/index.html" "Liquid Glass Resources"
require_contains "$site_dir/sitemap.xml" "https://liquidglassresources.com"
require_contains "$site_dir/assets/dist-styles.css" "tailwindcss"

require_absent "$site_dir/README.md"
require_absent "$site_dir/AGENTS.md"
require_absent "$site_dir/CLAUDE.md"
require_absent "$site_dir/config"
require_absent "$site_dir/docs"
require_absent "$site_dir/skills"
require_absent "$site_dir/scripts"
require_absent "$site_dir/package.json"
require_absent "$site_dir/package-lock.json"
require_absent "$site_dir/tailwind.config.js"

echo "Smoke check passed for $site_dir"
