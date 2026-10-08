#!/usr/bin/env bash
# Execution VERIFY (H2): PASS when dashboard dc_task_b has a dashboards_block:dashboard:comments_statistic component with count=daycount.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dc_task_b");
$found=FALSE;
if ($d) foreach ($d->getSections() as $sec) foreach ($sec->getComponents() as $c) {
  $cfg=$c->get("configuration");
  if (($cfg["id"] ?? "") === "dashboards_block:dashboard:comments_statistic" && ($cfg["count"] ?? "") === "daycount") $found=TRUE;
}
print ($found ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
