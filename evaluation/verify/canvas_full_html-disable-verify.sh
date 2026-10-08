#!/usr/bin/env bash
# Execution VERIFY (canvas_full_html H1): PASS only when the agent has DISABLED the Canvas
# Full HTML integration by setting canvas_full_html.settings:enabled = false. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val="$(drush cget canvas_full_html.settings enabled --format=string 2>/dev/null | tr -d '[:space:]')"
if [ "$val" = "0" ] || [ "$val" = "false" ] || [ "$val" = "" ]; then
  # Distinguish false from missing: require the key to exist and be falsey.
  exists="$(drush php:eval "var_export(\Drupal::config('canvas_full_html.settings')->get('enabled'));" 2>/dev/null)"
  if [ "$exists" = "false" ]; then
    echo "PASS: canvas_full_html.settings:enabled is false (integration disabled)"
    exit 0
  fi
fi
echo "FAIL: canvas_full_html.settings:enabled is not false (got '$val')"
exit 1
