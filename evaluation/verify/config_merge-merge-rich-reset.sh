#!/usr/bin/env bash
# Execution RESET: store the 3-way source states in state key config_merge_eval_h1 and delete
# the result key config_merge_eval_h1_result, so verify FAILS until the agent computes and
# stores the merged config. The scenario exercises: an accepted update (slogan), a retained
# customization (color=green), an addition (added), and an indexed-array substitution (tags).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("config_merge_eval_h1", [
    "previous" => ["slogan" => "old", "color" => "blue", "tags" => ["a", "b"]],
    "current"  => ["slogan" => "new", "color" => "blue", "tags" => ["a", "b", "c"], "added" => "yes"],
    "active"   => ["slogan" => "old", "color" => "green", "tags" => ["a", "b"]],
  ]);
  \Drupal::state()->delete("config_merge_eval_h1_result");
' >/dev/null 2>&1
echo "reset: config_merge_eval_h1 scenario set; result key cleared"
