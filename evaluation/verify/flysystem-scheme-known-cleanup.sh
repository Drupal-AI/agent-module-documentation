#!/usr/bin/env bash
# Introspection CLEANUP: remove the flyknown scheme block from settings.php and its dir. Exit 0.
set -uo pipefail
cd /var/www/html
python3 agent-module-documentation/evaluation/verify/flysystem-settings-edit.py remove flyknown
rm -rf web/sites/default/files/flysystem-eval-flyknown 2>/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: flyknown scheme removed"
