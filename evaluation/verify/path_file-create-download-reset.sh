#!/usr/bin/env bash
# Execution RESET: remove any "PF Task Doc" path_file_entity, its /pf-task-doc alias, and marker
# file, so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $store = \Drupal::entityTypeManager()->getStorage("path_file_entity");
  foreach ($store->loadByProperties(["name" => "PF Task Doc"]) as $pf) { $pf->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["alias" => "/pf-task-doc"]) as $a) { $a->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://pf_eval/pf-task-doc.txt"]) as $f) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: PF Task Doc entity/alias/file cleared"
