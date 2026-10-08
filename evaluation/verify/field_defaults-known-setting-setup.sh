#!/usr/bin/env bash
# Introspection SETUP: set field_defaults.settings retain_changed_date to a known NON-default
# value (0) so an inspecting agent can read it back. Baseline (shipped default) is 1.
set -uo pipefail
cd /var/www/html
drush cset field_defaults.settings retain_changed_date 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_defaults.settings retain_changed_date=0"
