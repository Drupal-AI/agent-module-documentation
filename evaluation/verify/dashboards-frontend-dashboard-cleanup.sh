#!/usr/bin/env bash
# Execution CLEANUP: remove any dashboard labeled 'Team Home'. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("dashboard");
foreach ($s->loadMultiple() as $d) { if ($d->label() === "Team Home") $d->delete(); }
if ($d = $s->load("dashboards_owner")) $d->delete();
' >/dev/null 2>&1
echo "cleanup: 'Team Home' dashboards removed"
