#!/usr/bin/env bash
# Introspection SETUP: store a 3-way merge scenario in Drupal State key config_merge_eval_keep
# where the extension changed timeout 30 -> 60 but the site customized it to 90. The agent must
# run config_merge's ConfigMerger on these states and report that the customization (90) is
# retained. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("config_merge_eval_keep", [
    "previous" => ["timeout" => 30],
    "current"  => ["timeout" => 60],
    "active"   => ["timeout" => 90],
  ]);
' >/dev/null 2>&1
echo "setup: state config_merge_eval_keep = {previous:30, current:60, active:90}"
