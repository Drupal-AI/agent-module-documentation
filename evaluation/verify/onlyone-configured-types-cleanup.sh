#!/usr/bin/env bash
# Introspection CLEANUP: restore onlyone_node_types to empty and delete the onlyone_eval
# content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("onlyone.settings")->set("onlyone_node_types", [])->save();
  if ($ct=\Drupal\node\Entity\NodeType::load("onlyone_eval")) { $ct->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: onlyone_node_types emptied and onlyone_eval removed"
