#!/usr/bin/env bash
# Execution VERIFY: PASS when dashboard dashboards_task exists with admin_label 'Ops Overview' and
# category 'Operations'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("dashboard")->load("dashboards_task");
  $ok = $d && $d->label() === "Ops Overview" && $d->get("category") === "Operations";
  print ($ok ? "PASS" : "FAIL")." label=".($d ? $d->label() : "none")." cat=".($d ? $d->get("category") : "none")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
