#!/usr/bin/env bash
# Execution RESET: write the unsorted source config config_normalizer_eval.data to active
# storage and delete the target state key config_normalizer_eval_sorted, so verify FAILS until
# the agent reads the config normalized and stores the result. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_normalizer_eval.data")
    ->setData(["zebra" => 1, "apple" => 2, "mango" => 3])->save();
  \Drupal::state()->delete("config_normalizer_eval_sorted");
' >/dev/null 2>&1
echo "reset: config_normalizer_eval.data set (unsorted); state config_normalizer_eval_sorted cleared"
