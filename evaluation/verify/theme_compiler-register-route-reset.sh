#!/usr/bin/env bash
# Execution RESET: ensure the tc_probe theme is uninstalled and its directory removed so NO
# theme_compiler.* route is registered (verify must FAIL on this empty state). Uninstalls the
# theme BEFORE removing its directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'try { \Drupal::service("theme_installer")->uninstall(["tc_probe"]); } catch (\Throwable $e) {}' >/dev/null 2>&1 || true
rm -rf web/themes/custom/tc_probe
drush cr >/dev/null 2>&1
echo "reset: tc_probe theme uninstalled and directory removed"
