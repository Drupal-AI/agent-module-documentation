#!/usr/bin/env bash
# Execution CLEANUP: remove any leftover dpp_task pathauto-state collections. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $cols = $db->select("key_value","kv")->fields("kv",["collection"])
    ->condition("collection", $db->escapeLike("domain_path_pathauto_state.dpp_task.") . "%", "LIKE")
    ->distinct()->execute()->fetchCol();
  foreach ($cols as $c) { \Drupal::keyValue($c)->deleteAll(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dpp_task pathauto-state collections cleared"
