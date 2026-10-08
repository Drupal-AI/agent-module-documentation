#!/usr/bin/env bash
# Execution VERIFY: PASS when conflict.settings resolution_type.default.default === "dialog". exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print (string) \Drupal::config("conflict.settings")->get("resolution_type.default.default");' 2>/dev/null)
echo "resolution_type.default.default=$out"
[ "$out" = "dialog" ] && exit 0 || exit 1
