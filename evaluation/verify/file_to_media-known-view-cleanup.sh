#!/usr/bin/env bash
# Introspection CLEANUP: delete ftm_known_view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("ftm_known_view")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view ftm_known_view removed"
