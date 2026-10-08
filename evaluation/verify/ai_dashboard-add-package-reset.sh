#!/usr/bin/env bash
# Execution RESET for "add the AI Tools package to the Extensions block". Sets the
# module_list_packages package filter to a baseline WITHOUT "AI Tools" (AI / AI (Experimental)
# / AI Providers) so verify FAILS until the agent adds it. Targets the component by block id.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("dashboard.dashboard.ai_dashboard");
  $layout = $cfg->get("layout");
  foreach ($layout[0]["components"] as $uuid => &$c) {
    if (($c["configuration"]["id"] ?? "") === "module_list_packages") {
      $c["configuration"]["packages"] = "AI\r\nAI (Experimental)\r\nAI Providers";
    }
  }
  $cfg->set("layout", $layout)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: Extensions packages = AI / AI (Experimental) / AI Providers (no AI Tools)"
