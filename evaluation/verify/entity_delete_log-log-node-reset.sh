#!/usr/bin/env bash
# Execution RESET (entity_delete_log): clear logging config + any prior node task rows/nodes so the
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("entity_delete_log.settings")->set("entity_types", [])->save();' >/dev/null 2>&1
drush sqlq "DELETE FROM entity_delete_log WHERE entity_title = 'edl_task_node'" >/dev/null 2>&1
drush php:eval '
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","edl_task_node")->execute();
  if ($ids) { $s=\Drupal::entityTypeManager()->getStorage("node"); $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entity_types=[], no edl_task_node rows/nodes"
