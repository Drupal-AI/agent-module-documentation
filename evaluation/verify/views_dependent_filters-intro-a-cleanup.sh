#!/usr/bin/env bash
# Introspection CLEANUP: delete the vdf_intro_a view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("vdf_intro_a")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vdf_intro_a removed"
