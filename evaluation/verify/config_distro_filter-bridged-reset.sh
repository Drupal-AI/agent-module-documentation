#!/usr/bin/env bash
# Execution RESET: write config_distro_eval.bridgeh to ACTIVE and clear state config_distro_filter_eval_ok
# so verify FAILS until the agent confirms the distribution storage (built through the bridge's
# filtered-import simulation) yields the same data as active for that item. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_distro_eval.bridgeh")->setData(["marker" => "BASE", "n" => 4])->save();
  \Drupal::state()->delete("config_distro_filter_eval_ok");
' >/dev/null 2>&1
echo "reset: active config_distro_eval.bridgeh set; state config_distro_filter_eval_ok cleared"
