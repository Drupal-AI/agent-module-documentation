#!/usr/bin/env bash
# Introspection SETUP: declare a single Flysystem scheme 'flyknown' (local driver) in
# settings.php so an inspecting agent can read back the scheme name + driver. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
python3 agent-module-documentation/evaluation/verify/flysystem-settings-edit.py add flyknown 'sites/default/files/flysystem-eval-flyknown' 1
drush cr >/dev/null 2>&1
echo "setup: \$settings['flysystem']['flyknown'] = local driver"
