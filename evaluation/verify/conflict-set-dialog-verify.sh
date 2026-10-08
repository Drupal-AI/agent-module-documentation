#!/usr/bin/env bash
# Execution VERIFY: PASS when conflict.settings resolution_type.node.article === "dialog". exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print (string) \Drupal::config("conflict.settings")->get("resolution_type.node.article");' 2>/dev/null)
echo "resolution_type.node.article=$out"
[ "$out" = "dialog" ] && exit 0 || exit 1
