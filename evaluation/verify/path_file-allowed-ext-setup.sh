#!/usr/bin/env bash
# Introspection SETUP: set path_file.settings allowed_extensions to a known, distinctive value so
# an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset path_file.settings allowed_extensions 'pf_eval_marker txt md svg' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: path_file.settings allowed_extensions = 'pf_eval_marker txt md svg'"
