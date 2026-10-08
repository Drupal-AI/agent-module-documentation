#!/usr/bin/env bash
# Execution VERIFY (migrate_skip_on_404): PASS when a migration config entity msk_task exists
# and applies the skip_on_404 process plugin somewhere in its process pipeline.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("migrate_plus.migration.msk_task");
  $process = $cfg->get("process") ?: [];
  $found = FALSE;
  array_walk_recursive($process, function ($v, $k) use (&$found) {
    if ($k === "plugin" && $v === "skip_on_404") { $found = TRUE; }
  });
  $exists = !$cfg->isNew();
  $ok = ($exists && $found);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists ? "yes" : "no") . " skip_on_404=" . ($found ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
