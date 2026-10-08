#!/usr/bin/env bash
# Execution VERIFY (H1): PASS when dashboard dv_task embeds the dashboard_last_content view via the
# view_embed widget (component id dashboards_block:dashboard:view_embed, configuration.view referencing
# dashboard_last_content).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dv_task");
$found=FALSE;
if ($d) foreach ($d->getSections() as $sec) foreach ($sec->getComponents() as $c) {
  $cfg=$c->get("configuration");
  if (($cfg["id"] ?? "") === "dashboards_block:dashboard:view_embed" && strpos((string)($cfg["view"] ?? ""), "dashboard_last_content") === 0) $found=TRUE;
}
print ($found ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
