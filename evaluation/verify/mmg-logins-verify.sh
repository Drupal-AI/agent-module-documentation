#!/usr/bin/env bash
# Execution VERIFY: PASS when some multigraph's sensors map includes user_failed_logins. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\monitoring_multigraph\Entity\Multigraph;
  $found = FALSE; $where = "";
  foreach (Multigraph::loadMultiple() as $m) {
    $s = $m->get("sensors") ?? [];
    if (array_key_exists("user_failed_logins", $s)) { $found = TRUE; $where = $m->id(); break; }
  }
  print ($found ? "PASS" : "FAIL") . " multigraph=" . ($where ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
