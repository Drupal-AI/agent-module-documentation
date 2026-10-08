#!/usr/bin/env bash
# Execution CLEANUP: delete the micon_ct_task content type. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($t = \Drupal\node\Entity\NodeType::load("micon_ct_task")) { $t->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: micon_ct_task removed"
