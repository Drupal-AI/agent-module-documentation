#!/usr/bin/env bash
# Introspection SETUP: set a known excluded selector in formtips.settings:formtips_selectors so
# the agent can read back which selector is excluded from tooltip conversion. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset formtips.settings formtips_selectors '#formtips-eval-skip' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: formtips.settings formtips_selectors='#formtips-eval-skip'"
