#!/usr/bin/env bash
# HARD reset: disable both taxonomy-term output and exposed-field output so the
# verify FAILS on empty state; the agent must enable both.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("output_terms", FALSE)->set("output_fields", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: datalayer output_terms=false output_fields=false"
