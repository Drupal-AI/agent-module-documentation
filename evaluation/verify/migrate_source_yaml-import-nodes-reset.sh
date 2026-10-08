#!/usr/bin/env bash
# Execution RESET/CLEANUP for the YAML->node import case: delete any Article nodes titled
# 'MSY Alpha'/'MSY Beta', remove the msy_import migration config (and its map/message tables),
# and remove the candidate YAML data file, so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", ["MSY Alpha", "MSY Beta"], "IN")->execute();
  if ($ids) { $storage = \Drupal::entityTypeManager()->getStorage("node"); $storage->delete($storage->loadMultiple($ids)); }
' >/dev/null 2>&1
# Drop migrate map/message tables if present, then delete the config.
drush php:eval '
  $db = \Drupal::database();
  foreach (["migrate_map_msy_import", "migrate_message_msy_import"] as $t) {
    if ($db->schema()->tableExists($t)) { $db->schema()->dropTable($t); }
  }
  \Drupal::configFactory()->getEditable("migrate_plus.migration.msy_import")->delete();
' >/dev/null 2>&1
rm -f /var/www/html/msy_import.yml
drush cr >/dev/null 2>&1
echo "reset: MSY nodes, msy_import migration and /var/www/html/msy_import.yml removed"
