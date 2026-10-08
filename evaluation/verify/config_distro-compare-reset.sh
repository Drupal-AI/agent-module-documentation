#!/usr/bin/env bash
# Execution RESET: write config_distro_eval.cmph to ACTIVE storage and clear the target state
# key, so verify FAILS until the agent compares the distro storage's copy of that config against
# the active copy and records the result. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_distro_eval.cmph")->setData(["marker" => "BASE", "n" => 3])->save();
  \Drupal::state()->delete("config_distro_eval_match");
' >/dev/null 2>&1
echo "reset: active config_distro_eval.cmph set; state config_distro_eval_match cleared"
