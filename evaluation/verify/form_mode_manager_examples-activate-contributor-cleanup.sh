#!/usr/bin/env bash
# Execution CLEANUP: remove the node.article.contributor form display (leaves the shipped
# node_form_mode_example.contributor display untouched). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.contributor")) { $d->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.contributor form display removed"
