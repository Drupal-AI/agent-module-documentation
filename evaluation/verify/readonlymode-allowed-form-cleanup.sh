#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default (empty additional edit list). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset readonlymode.settings forms.additional.edit '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: readonlymode forms.additional.edit=''"
