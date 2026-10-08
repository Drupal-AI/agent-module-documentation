#!/usr/bin/env bash
# Introspection CLEANUP: delete the micon_ct_med content type. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($t = \Drupal\node\Entity\NodeType::load("micon_ct_med")) { $t->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: micon_ct_med removed"
