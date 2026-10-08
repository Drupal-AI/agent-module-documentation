#!/usr/bin/env bash
# Execution RESET: write config_normalizer_eval.list (an indexed 'items' array in unsorted
# order) to active storage and clear state key config_normalizer_eval_list, so verify FAILS
# until the agent stores the normalized (value-sorted) result. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_normalizer_eval.list")
    ->setData(["items" => ["zebra", "apple", "mango"]])->save();
  \Drupal::state()->delete("config_normalizer_eval_list");
' >/dev/null 2>&1
echo "reset: config_normalizer_eval.list set (items zebra,apple,mango); state cleared"
