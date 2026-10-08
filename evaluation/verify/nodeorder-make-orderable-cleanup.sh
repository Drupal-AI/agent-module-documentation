#!/usr/bin/env bash
# Execution CLEANUP: unmark nodeorder_hard orderable and delete the vocabulary. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  \Drupal::service("nodeorder.config_manager")->updateOrderableValue("nodeorder_hard", FALSE);
  if ($v = Vocabulary::load("nodeorder_hard")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: nodeorder_hard removed and unmarked"
