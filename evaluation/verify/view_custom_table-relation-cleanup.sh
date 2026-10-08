#!/usr/bin/env bash
# Execution CLEANUP (view_custom_table): unregister vct_rel and drop the table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("view_custom_table.tables");
  if ($c->get("vct_rel") !== NULL) { $c->clear("vct_rel")->save(); }
  $s = \Drupal::database()->schema();
  if ($s->tableExists("vct_rel")) { $s->dropTable("vct_rel"); }
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vct_rel unregistered and dropped"
