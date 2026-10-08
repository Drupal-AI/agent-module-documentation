#!/usr/bin/env bash
# Introspection SETUP: import a small parent/child term pair into the 'tags' vocabulary using the
# module's ImportController, so the agent must inspect the live taxonomy to report the parent of
# a child term. Idempotent (clears its own tcei_ terms first). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\term_csv_export_import\Controller\ImportController;
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach (["tcei_Region","tcei_City"] as $n) { foreach ($ts->loadByProperties(["name"=>$n,"vid"=>"tags"]) as $t) { $t->delete(); } }
  $csv = "name,status,description__value,description__format,weight,parent_name\n"
       . "tcei_Region,1,,basic_html,0,\n"
       . "tcei_City,1,,basic_html,0,tcei_Region\n";
  (new ImportController($csv, "tags"))->execute(FALSE, FALSE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: imported tcei_Region and its child tcei_City into vocabulary tags"
