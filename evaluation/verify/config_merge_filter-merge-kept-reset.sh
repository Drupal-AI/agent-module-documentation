#!/usr/bin/env bash
# Execution RESET: seed snapshot (previous n=1) and active (customized n=99) for
# config_merge_filter_eval.item, and clear the result state key, so verify FAILS until the agent
# drives the config_merge filter and stores the merged output. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("config.storage.snapshot")->write("config_merge_filter_eval.item", ["n" => 1, "label" => "base"]);
  \Drupal::service("config.storage")->write("config_merge_filter_eval.item", ["n" => 99, "label" => "base"]);
  \Drupal::state()->delete("config_merge_filter_eval_kept");
' >/dev/null 2>&1
echo "reset: snapshot n=1, active n=99; state config_merge_filter_eval_kept cleared"
