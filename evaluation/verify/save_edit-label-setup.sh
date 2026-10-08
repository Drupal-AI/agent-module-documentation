#!/usr/bin/env bash
# Introspection SETUP: set a distinctive Save & Edit button label so an inspecting agent can
# read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset save_edit.settings button_value 'Apply Now' -y >/dev/null 2>&1
echo "setup: save_edit.settings button_value='Apply Now'"
