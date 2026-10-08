#!/usr/bin/env bash
# Introspection SETUP: force a known admin-language policy (assign 'en', prevent override) so an agent
# can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset admin_user_language.settings default_language_to_assign en -y >/dev/null 2>&1
drush cset admin_user_language.settings prevent_user_override true -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: admin_user_language.settings default_language_to_assign=en prevent_user_override=true"
