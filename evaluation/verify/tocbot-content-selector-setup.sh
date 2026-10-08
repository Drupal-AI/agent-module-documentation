#!/usr/bin/env bash
# Introspection SETUP (tocbot): set tocbot.settings content_selector to a known distinctive value
# so an agent can read back which container Tocbot scans for headings on this site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tocbot.settings")->set("content_selector", "main.toc-content-xyz")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tocbot.settings content_selector = main.toc-content-xyz"
