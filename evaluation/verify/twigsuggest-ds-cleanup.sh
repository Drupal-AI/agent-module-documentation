#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("twigsuggest.settings"); if(!$c->isNew()){$c->delete();}' >/dev/null 2>&1
echo "cleanup: twigsuggest.settings removed (baseline: unset)"
