#!/usr/bin/env bash
# Introspection CLEANUP: delete the PF Eval Doc path_file_entity, its alias, and the marker file.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $store = \Drupal::entityTypeManager()->getStorage("path_file_entity");
  foreach ($store->loadByProperties(["name" => "PF Eval Doc"]) as $pf) { $pf->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["alias" => "/pf-eval-doc"]) as $a) { $a->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://pf_eval/pf-eval-doc.txt"]) as $f) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: PF Eval Doc entity, alias and file removed"
