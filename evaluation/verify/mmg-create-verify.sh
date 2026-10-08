#!/usr/bin/env bash
# Execution VERIFY: PASS when multigraph mg_task exists and aggregates BOTH named sensors. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\monitoring_multigraph\Entity\Multigraph;
  $m = Multigraph::load("mg_task");
  $sensors = $m ? array_keys($m->get("sensors") ?? []) : [];
  $ok = $m && in_array("core_cron_last_run_age", $sensors, TRUE) && in_array("system_load_average", $sensors, TRUE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($m ? "yes" : "no") . " sensors=" . json_encode($sensors) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
