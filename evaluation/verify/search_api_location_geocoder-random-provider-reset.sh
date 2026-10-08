#!/usr/bin/env bash
# Execution RESET: remove salg_-prefixed geocoder providers, so verify FAILS until the agent
# creates one that uses the 'random' geocoder plugin. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("geocoder_provider");
  foreach ($s->loadMultiple() as $id => $p) { if (strpos($id, "salg_") === 0) { $p->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no salg_* geocoder providers"
