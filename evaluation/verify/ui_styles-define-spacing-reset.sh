#!/usr/bin/env bash
# Execution RESET (ui_styles main): ensure the multi-option style plugin ui_styles_eval_spacing
# does NOT exist so verify FAILS on empty state. pmu before rm.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_eval_spacing -y >/dev/null 2>&1
rm -rf web/modules/custom/ui_styles_eval_spacing
drush cr >/dev/null 2>&1
echo "reset: ui_styles_eval_spacing module/plugin removed; not discoverable"
