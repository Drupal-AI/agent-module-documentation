#!/usr/bin/env bash
# Execution RESET: remove any dashboard labeled 'Team Home' (so verify FAILS until created). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("dashboard");
foreach ($s->loadMultiple() as $d) { if ($d->label() === "Team Home") $d->delete(); }
if ($d = $s->load("dashboards_owner")) $d->delete();
' >/dev/null 2>&1
echo "reset: no dashboard labeled 'Team Home'"
