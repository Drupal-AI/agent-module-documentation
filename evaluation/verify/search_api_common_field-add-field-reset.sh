#!/usr/bin/env bash
# Execution RESET: (re)create a disabled Search API index scf_task with two datasources
# (node, user) and NO common field / common_field processor, so verify FAILS until the
# agent adds one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("scf_task")) { $i->delete(); }
  $index = Index::create([
    "id" => "scf_task", "name" => "SCF Task", "status" => FALSE,
    "datasource_settings" => ["entity:node" => [], "entity:user" => []],
  ]);
  $index->save();
' >/dev/null 2>&1
echo "reset: index scf_task present with two datasources and no common field"
