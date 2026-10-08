#!/usr/bin/env bash
# Introspection SETUP: add a known extra submittable form id to the allow-list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset readonlymode.settings forms.additional.edit 'rom_probe_widget_form' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: readonlymode forms.additional.edit=rom_probe_widget_form"
