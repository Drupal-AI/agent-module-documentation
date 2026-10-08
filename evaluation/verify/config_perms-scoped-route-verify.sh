#!/usr/bin/env bash
# HARD execution verify for config_perms: an ENABLED custom_perms_entity must exist whose
# route field includes the core cron settings route (system.cron_settings), with a non-empty
# label (the label becomes the grantable permission title). Any machine id the agent chose is
# accepted. Prints PASS/FAIL, exits 0 (pass) / 1 (fail). Filters unrelated deprecation noise.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $found = ""; $label = ""; $route = "";
  foreach (\Drupal::entityTypeManager()->getStorage("custom_perms_entity")->loadMultiple() as $e) {
    $routes = config_perms_parse_path($e->getRoute());
    if ($e->getStatus() && in_array("system.cron_settings", $routes, TRUE) && trim((string) $e->label()) !== "") {
      $ok = TRUE; $found = $e->id(); $label = $e->label(); $route = $e->getRoute();
      break;
    }
  }
  print ($ok ? "PASS" : "FAIL") . " id=" . $found . " label=" . $label . " route=" . str_replace("\n", ",", $route) . "\n";
' 2>/dev/null | grep -Ev '^\s*(Deprecated|Warning|Notice):' | grep -E '^(PASS|FAIL)')

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
