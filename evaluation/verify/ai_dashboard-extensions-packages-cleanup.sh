#!/usr/bin/env bash
# Introspection CLEANUP: restore the AI Dashboard 'Extensions' block package filter to its
# install baseline (AI / AI (Experimental) / AI Providers / AI Tools). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("dashboard.dashboard.ai_dashboard");
  $layout = $cfg->get("layout");
  foreach ($layout[0]["components"] as $uuid => &$c) {
    if (($c["configuration"]["id"] ?? "") === "module_list_packages") {
      $c["configuration"]["packages"] = "AI\r\nAI (Experimental)\r\nAI Providers\r\nAI Tools";
    }
  }
  $cfg->set("layout", $layout)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: Extensions block packages restored to baseline"
