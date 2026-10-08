#!/usr/bin/env bash
# Introspection CLEANUP: unmark nodeorder_tags orderable and delete the vocabulary. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  \Drupal::service("nodeorder.config_manager")->updateOrderableValue("nodeorder_tags", FALSE);
  if ($v = Vocabulary::load("nodeorder_tags")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: nodeorder_tags removed and unmarked"
