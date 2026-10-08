#!/usr/bin/env bash
# Execution CLEANUP (entity_delete_log): same as reset — clear config + task rows/nodes. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("entity_delete_log.settings")->set("entity_types", [])->save();' >/dev/null 2>&1
drush sqlq "DELETE FROM entity_delete_log WHERE entity_title = 'edl_task_node'" >/dev/null 2>&1
drush php:eval '
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","edl_task_node")->execute();
  if ($ids) { $s=\Drupal::entityTypeManager()->getStorage("node"); $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "cleanup: done"
