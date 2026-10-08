#!/usr/bin/env bash
# Introspection SETUP: set social_link_field.settings attached_fa to FALSE (baseline default is
# TRUE), so an inspecting agent can read that Font Awesome is not being auto-attached. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset social_link_field.settings attached_fa 0 -y >/dev/null 2>&1
echo "setup: social_link_field.settings attached_fa=false"
