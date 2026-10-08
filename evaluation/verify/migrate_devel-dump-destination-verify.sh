#!/usr/bin/env bash
# Execution VERIFY: PASS when the migdev_dump migration config has a process step using the
# migrate_devel 'debug' plugin whose 'dump' key is set to 'destination'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $process = \Drupal::config("migrate_plus.migration.migdev_dump")->get("process") ?? [];
  $found = FALSE;
  $walk = function ($node) use (&$walk, &$found) {
    if (is_array($node)) {
      if (isset($node["plugin"]) && $node["plugin"] === "debug" && ($node["dump"] ?? NULL) === "destination") { $found = TRUE; }
      foreach ($node as $v) { $walk($v); }
    }
  };
  $walk($process);
  print ($found ? "PASS" : "FAIL") . " debug_dump_destination=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
