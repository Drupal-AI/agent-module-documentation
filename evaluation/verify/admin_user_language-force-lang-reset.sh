#!/usr/bin/env bash
# Execution RESET: baseline admin_user_language.settings to shipped defaults (no preference, override
# allowed), so verify FAILS until the agent forces a language. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset admin_user_language.settings default_language_to_assign '-1' -y >/dev/null 2>&1
drush cset admin_user_language.settings prevent_user_override false -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: admin_user_language.settings = -1 / false"
