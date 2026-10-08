#!/usr/bin/env bash
# Introspection SETUP: store a 3-way merge scenario in state key config_merge_eval_update where
# the extension changed timeout 30 -> 60 and the site did NOT customize it (active still 30), so
# running config_merge's ConfigMerger yields the update (60). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("config_merge_eval_update", [
    "previous" => ["timeout" => 30],
    "current"  => ["timeout" => 60],
    "active"   => ["timeout" => 30],
  ]);
' >/dev/null 2>&1
echo "setup: state config_merge_eval_update = {previous:30, current:60, active:30}"
