#!/usr/bin/env bash
# Introspection CLEANUP: delete the vjs_known view created by the matching setup.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("vjs_known")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vjs_known removed"
