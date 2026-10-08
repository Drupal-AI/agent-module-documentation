#!/usr/bin/env bash
# Execution RESET (ui_styles main): ensure the style plugin ui_styles_eval_bg does NOT exist
# (uninstall + remove any fixture module) so verify FAILS on empty state. pmu before rm.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_eval_bg -y >/dev/null 2>&1
rm -rf web/modules/custom/ui_styles_eval_bg
drush cr >/dev/null 2>&1
echo "reset: ui_styles_eval_bg module/plugin removed; not discoverable"
