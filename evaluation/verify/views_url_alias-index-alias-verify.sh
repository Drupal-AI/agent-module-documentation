#!/usr/bin/env bash
# Execution VERIFY: PASS when the module's views_url_alias table has a row for 'VUA Task Node'
# with alias '/vua-task-path'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("node")->condition("title","VUA Task Node")->accessCheck(FALSE)->execute();
  $id = $ids ? reset($ids) : 0;
  $alias = $id ? \Drupal::database()->select("views_url_alias","v")->fields("v",["alias"])
    ->condition("entity_type","node")->condition("entity_id",$id)->execute()->fetchField() : FALSE;
  $ok = ($alias === "/vua-task-path");
  print ($ok ? "PASS" : "FAIL") . " node=$id alias=" . var_export($alias, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
