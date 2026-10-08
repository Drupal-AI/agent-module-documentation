#!/usr/bin/env bash
# Execution RESET for "set the Documentation block soft_limit to 6". Restores soft_limit to the
# install default (4) so verify FAILS until the agent changes it to 6. Targets the component by
# block id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("dashboard.dashboard.ai_dashboard");
  $layout = $cfg->get("layout");
  foreach ($layout[0]["components"] as $uuid => &$c) {
    if (($c["configuration"]["id"] ?? "") === "ai_documentation") {
      $c["configuration"]["soft_limit"] = 4;
    }
  }
  $cfg->set("layout", $layout)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: Documentation block soft_limit = 4 (default)"
