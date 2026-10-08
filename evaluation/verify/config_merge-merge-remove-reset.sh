#!/usr/bin/env bash
# Execution RESET: store a 3-way scenario in state key config_merge_eval_h2 where the extension
# both removed a key (drop) and changed a value (mod 3->4), with the site uncustomized, and
# clear result key config_merge_eval_h2_result so verify FAILS until the agent stores the merge.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("config_merge_eval_h2", [
    "previous" => ["keep" => 1, "drop" => 2, "mod" => 3],
    "current"  => ["keep" => 1, "mod" => 4],
    "active"   => ["keep" => 1, "drop" => 2, "mod" => 3],
  ]);
  \Drupal::state()->delete("config_merge_eval_h2_result");
' >/dev/null 2>&1
echo "reset: config_merge_eval_h2 scenario set; result key cleared"
