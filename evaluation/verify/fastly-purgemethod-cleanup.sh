#!/usr/bin/env bash
# Introspection CLEANUP: remove the keys we set (baseline: fastly ships no config/install). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("fastly.settings"); $c->clear("purge_method"); $c->clear("purge_logging"); $c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fastly.settings purge_method/purge_logging cleared"
