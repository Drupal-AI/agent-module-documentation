#!/usr/bin/env bash
# Introspection SETUP: set the AI Dashboard 'Extensions' block (module_list_packages) package
# filter to a KNOWN value so an inspecting agent can read it back. Distinctive marker: the
# package "AI Utilities". Targets the component by block id (layout is uuid-keyed). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("dashboard.dashboard.ai_dashboard");
  $layout = $cfg->get("layout");
  foreach ($layout[0]["components"] as $uuid => &$c) {
    if (($c["configuration"]["id"] ?? "") === "module_list_packages") {
      $c["configuration"]["packages"] = "AI\r\nAI Providers\r\nAI Utilities";
    }
  }
  $cfg->set("layout", $layout)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Extensions block packages = AI / AI Providers / AI Utilities"
