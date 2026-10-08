#!/usr/bin/env bash
# Introspection CLEANUP: restore the AI Dashboard 'Documentation' block soft_limit to the
# install default (4). Idempotent. Exit 0.
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
echo "cleanup: Documentation block soft_limit restored to 4"
