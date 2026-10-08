#!/usr/bin/env bash
# Execution VERIFY: PASS when bin pcb_task holds pcb_key='pcb_persist' AND it still holds it
# after a rebuild-style deleteAll() (proving permanence). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $bin = \Drupal::service("cache.backend.permanent_database")->get("pcb_task");
  $before = $bin->get("pcb_key");
  $bin->deleteAll();               // rebuild semantics: no-op for a permanent bin
  $after = $bin->get("pcb_key");
  $ok = ($before && $before->data === "pcb_persist" && $after && $after->data === "pcb_persist");
  print ($ok ? "PASS" : "FAIL")
    . " before=" . ($before ? var_export($before->data, TRUE) : "MISS")
    . " after_deleteAll=" . ($after ? var_export($after->data, TRUE) : "MISS") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
