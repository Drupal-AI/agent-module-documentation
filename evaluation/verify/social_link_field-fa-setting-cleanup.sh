#!/usr/bin/env bash
# Introspection CLEANUP: restore social_link_field.settings attached_fa to its shipped default TRUE.
set -uo pipefail
cd /var/www/html
drush cset social_link_field.settings attached_fa 1 -y >/dev/null 2>&1
echo "cleanup: social_link_field.settings attached_fa=true (default restored)"
