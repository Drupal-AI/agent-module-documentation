#!/usr/bin/env bash
# Introspection SETUP: set a known placeholder text so the agent can read it back. Placeholders
# are the local dev-safe render (no live ad call). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset adsense.settings adsense_placeholder_text 'ADSENSE EVAL SLOT' -y >/dev/null 2>&1
echo "setup: adsense.settings adsense_placeholder_text='ADSENSE EVAL SLOT'"
