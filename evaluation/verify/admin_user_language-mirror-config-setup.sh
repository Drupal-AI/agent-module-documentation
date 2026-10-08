#!/usr/bin/env bash
# Introspection SETUP: configure the special 'preferred_langcode' (mirror the user's own site
# language) option, override allowed. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset admin_user_language.settings default_language_to_assign preferred_langcode -y >/dev/null 2>&1
drush cset admin_user_language.settings prevent_user_override false -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: admin_user_language.settings default_language_to_assign=preferred_langcode prevent_user_override=false"
