#!/usr/bin/env bash
# Execution RESET: write config_distro_eval.readh (with a marker) to the ACTIVE storage and delete
# the target state key, so verify FAILS until the agent reads the config through the distro
# storage service and stores it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_distro_eval.readh")->setData(["marker" => "DISTRO123", "n" => 5])->save();
  \Drupal::state()->delete("config_distro_eval_read");
' >/dev/null 2>&1
echo "reset: active config_distro_eval.readh set (marker DISTRO123); state config_distro_eval_read cleared"
