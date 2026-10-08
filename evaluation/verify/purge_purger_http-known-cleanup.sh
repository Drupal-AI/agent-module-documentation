#!/usr/bin/env bash
# Introspection CLEANUP (purge_purger_http): delete the pph_known settings entity. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\purge_purger_http\Entity\HttpPurgerSettings;
  if ($s = HttpPurgerSettings::load("pph_known")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: purge_purger_http.settings.pph_known removed"
