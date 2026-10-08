#!/usr/bin/env bash
# Introspection CLEANUP: delete the eref_eval view. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("eref_eval")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.eref_eval removed"
