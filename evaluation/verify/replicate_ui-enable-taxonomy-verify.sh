#!/usr/bin/env bash
# Live-state verification for the "enable Replicate UI for taxonomy_term with edit-access
# checking" hard case. Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# Three checks, all required:
#   cfg   — replicate_ui.settings.entity_types contains "taxonomy_term"
#   edit  — replicate_ui.settings.check_edit_access is TRUE
#   route — the derived route entity.taxonomy_term.replicate exists AND, because
#           check_edit_access is on, carries the _entity_access: taxonomy_term.update
#           requirement (proving the setting propagated into the rebuilt route).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = \Drupal::config("replicate_ui.settings");
  $has = in_array("taxonomy_term", (array) $cfg->get("entity_types"), TRUE);
  $edit = (bool) $cfg->get("check_edit_access");
  $route = FALSE; $req = "";
  try {
    $r = \Drupal::service("router.route_provider")->getRouteByName("entity.taxonomy_term.replicate");
    $req = (string) $r->getRequirement("_entity_access");
    $route = ($r->getPath() === "/taxonomy/term/{taxonomy_term}/replicate" && $req === "taxonomy_term.update");
  } catch (\Throwable $e) { $route = FALSE; }
  $pass = $has && $edit && $route;
  print "RESULT " . ($pass ? "PASS" : "FAIL") . " cfg=" . ($has?1:0) . " edit=" . ($edit?1:0) . " route=" . ($route?1:0) . " req=" . $req . "\n";
' 2>/dev/null | grep "^RESULT ")

echo "$out"
echo "$out" | grep -q '^RESULT PASS' && exit 0 || exit 1
