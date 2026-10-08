#!/usr/bin/env bash
# Introspection SETUP (canvas_full_html M2): ensure the integration is enabled (baseline) so
# the agent inspects the live canvas_full_html CKEditor 5 editor config / toolbar. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset canvas_full_html.settings enabled 1 -y >/dev/null 2>&1
echo "setup: canvas_full_html.settings:enabled = true; editor.editor.canvas_full_html present"
