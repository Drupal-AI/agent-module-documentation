#!/usr/bin/env bash
# Introspection CLEANUP: delete the vsmf_mute view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("vsmf_mute")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vsmf_mute removed"
