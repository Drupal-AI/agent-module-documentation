#!/usr/bin/env bash
# Introspection CLEANUP (view_custom_table): unregister vct_known and drop the table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("view_custom_table.tables");
  if ($c->get("vct_known") !== NULL) { $c->clear("vct_known")->save(); }
  $s = \Drupal::database()->schema();
  if ($s->tableExists("vct_known")) { $s->dropTable("vct_known"); }
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vct_known unregistered and dropped"
