#!/usr/bin/env bash
# Introspection SETUP: turn the CDN option OFF so the site self-hosts CodeMirror, for an agent
# to read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("codemirror_editor.settings")->set("cdn", FALSE)->save();
' >/dev/null 2>&1
echo "setup: codemirror_editor.settings cdn=false (self-hosted)"
