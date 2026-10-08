#!/usr/bin/env bash
# Live-state verification for the "enable Replicate UI for nodes" hard case.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks:
#   cfg   — replicate_ui.settings.entity_types contains "node"
#   route — the derived route entity.node.replicate exists at /node/{node}/replicate
# Both must hold: enabling the config alone is not enough — the agent must also rebuild
# routes (drush cr / router rebuild) so the route/tab actually appears.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $types = (array) \Drupal::config("replicate_ui.settings")->get("entity_types");
  $cfg = in_array("node", $types, TRUE);
  $route = FALSE; $path = "";
  try {
    $r = \Drupal::service("router.route_provider")->getRouteByName("entity.node.replicate");
    $path = $r->getPath();
    $route = ($path === "/node/{node}/replicate");
  } catch (\Throwable $e) { $route = FALSE; }
  print "RESULT " . (($cfg && $route) ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " route=" . ($route?1:0) . " path=" . $path . "\n";
' 2>/dev/null | grep "^RESULT ")

echo "$out"
echo "$out" | grep -q '^RESULT PASS' && exit 0 || exit 1
