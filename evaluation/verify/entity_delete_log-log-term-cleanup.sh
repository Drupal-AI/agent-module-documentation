#!/usr/bin/env bash
# Execution CLEANUP (entity_delete_log): clear config + task rows/terms. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("entity_delete_log.settings")->set("entity_types", [])->save();' >/dev/null 2>&1
drush sqlq "DELETE FROM entity_delete_log WHERE entity_title = 'edl_task_term'" >/dev/null 2>&1
drush php:eval '
  $ids = \Drupal::entityQuery("taxonomy_term")->accessCheck(FALSE)->condition("name","edl_task_term")->execute();
  if ($ids) { $s=\Drupal::entityTypeManager()->getStorage("taxonomy_term"); $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "cleanup: done"
