#!/usr/bin/env bash
# Execution RESET/CLEANUP: remove the baseline artifact so verify FAILS on empty state. The
# config:inspect --generate-baseline command writes to drush's cwd, the docroot web/. Exit 0.
set -uo pipefail
rm -f /var/www/html/web/config_inspector-baseline.json /var/www/html/config_inspector-baseline.json
echo "reset: removed config_inspector-baseline.json (web/ and project root)"
