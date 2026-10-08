#!/usr/bin/env bash
# Introspection CLEANUP: delete view fc_agenda. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("fc_agenda")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: view fc_agenda removed"
