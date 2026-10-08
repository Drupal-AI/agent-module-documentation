#!/usr/bin/env bash
# Execution VERIFY: PASS when cas_attributes.settings contains a role mapping granting
# cas_attributes_task whenever the CAS attribute eduPersonAffiliation contains 'faculty'
# (method contains_any, remove_without_match TRUE), applied on every login.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("cas_attributes.settings");
  $mappings = (array) $c->get("role.mappings");
  $freq = $c->get("role.sync_frequency");
  $match = NULL;
  foreach ($mappings as $m) {
    if (($m["rid"] ?? NULL) === "cas_attributes_task"
        && strtolower($m["attribute"] ?? "") === "edupersonaffiliation"
        && strtolower($m["value"] ?? "") === "faculty"
        && ($m["method"] ?? NULL) === "contains_any"
        && !empty($m["remove_without_match"])
        && empty($m["negate"])) {
      $match = $m;
      break;
    }
  }
  $ok = ($match !== NULL) && ((int) $freq === 2);
  print ($ok ? "PASS" : "FAIL") . " mappings=" . count($mappings)
    . " sync_frequency=" . var_export($freq, TRUE)
    . " match=" . ($match ? json_encode($match) : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
