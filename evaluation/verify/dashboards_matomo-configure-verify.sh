#!/usr/bin/env bash
# Execution VERIFY (H2): PASS when dashboard dm_task_b has a component with id dashboards_block:dashboard:matomo_countries.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dm_task_b");
$found=FALSE;
if ($d) foreach ($d->getSections() as $sec) foreach ($sec->getComponents() as $c) { if (($c->get("configuration")["id"] ?? "") === "dashboards_block:dashboard:matomo_countries") $found=TRUE; }
print ($found ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
