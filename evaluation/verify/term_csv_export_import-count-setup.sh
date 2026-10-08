#!/usr/bin/env bash
# Introspection SETUP: import a parent tcei_Continent with three children into the 'tags'
# vocabulary via ImportController, so the agent must inspect the live taxonomy to count how many
# child terms it has. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\term_csv_export_import\Controller\ImportController;
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach (["tcei_Continent","tcei_Kenya","tcei_Egypt","tcei_Ghana"] as $n) { foreach ($ts->loadByProperties(["name"=>$n,"vid"=>"tags"]) as $t) { $t->delete(); } }
  $csv = "name,status,description__value,description__format,weight,parent_name\n"
       . "tcei_Continent,1,,basic_html,0,\n"
       . "tcei_Kenya,1,,basic_html,0,tcei_Continent\n"
       . "tcei_Egypt,1,,basic_html,0,tcei_Continent\n"
       . "tcei_Ghana,1,,basic_html,0,tcei_Continent\n";
  (new ImportController($csv, "tags"))->execute(FALSE, FALSE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: imported tcei_Continent with 3 children (tcei_Kenya, tcei_Egypt, tcei_Ghana) into tags"
