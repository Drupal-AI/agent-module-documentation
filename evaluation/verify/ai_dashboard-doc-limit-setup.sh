#!/usr/bin/env bash
# Introspection SETUP: set the AI Dashboard 'Documentation' block (ai_documentation) soft_limit
# to a KNOWN value (7, default is 4) so an inspecting agent can read it back. Targets the
# component by block id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("dashboard.dashboard.ai_dashboard");
  $layout = $cfg->get("layout");
  foreach ($layout[0]["components"] as $uuid => &$c) {
    if (($c["configuration"]["id"] ?? "") === "ai_documentation") {
      $c["configuration"]["soft_limit"] = 7;
    }
  }
  $cfg->set("layout", $layout)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Documentation block soft_limit = 7"
