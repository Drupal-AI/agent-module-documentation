#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles main): uninstall and remove the fixture module. Must pmu
# BEFORE removing the directory (an enabled module with no dir fatals the kernel). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_eval_fixture -y >/dev/null 2>&1
rm -rf web/modules/custom/ui_styles_eval_fixture
drush cr >/dev/null 2>&1
echo "cleanup: ui_styles_eval_fixture uninstalled and removed"
