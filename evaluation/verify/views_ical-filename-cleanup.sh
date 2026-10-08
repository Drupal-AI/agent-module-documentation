#!/usr/bin/env bash
# Introspection CLEANUP (views_ical M2): delete the vical_named view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v=View::load("vical_named")){$v->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vical_named removed"
