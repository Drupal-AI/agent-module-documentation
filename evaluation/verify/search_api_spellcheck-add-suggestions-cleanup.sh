#!/usr/bin/env bash
# Execution CLEANUP: delete the sais_sug view. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("sais_sug")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view sais_sug removed"
