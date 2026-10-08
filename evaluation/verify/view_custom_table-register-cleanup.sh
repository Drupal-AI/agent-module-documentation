#!/usr/bin/env bash
# Execution CLEANUP (view_custom_table): unregister vct_task and drop the table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("view_custom_table.tables");
  if ($c->get("vct_task") !== NULL) { $c->clear("vct_task")->save(); }
  $s = \Drupal::database()->schema();
  if ($s->tableExists("vct_task")) { $s->dropTable("vct_task"); }
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vct_task unregistered and dropped"
