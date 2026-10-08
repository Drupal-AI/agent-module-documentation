#!/usr/bin/env bash
# Execution VERIFY (H1): PASS when dashboard ds_task_a has a component with id dashboards_block:dashboard:node_most_readed.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("ds_task_a");
$found=FALSE;
if ($d) foreach ($d->getSections() as $sec) foreach ($sec->getComponents() as $c) {
  if (($c->get("configuration")["id"] ?? "") === "dashboards_block:dashboard:node_most_readed") $found=TRUE;
}
print ($found ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
