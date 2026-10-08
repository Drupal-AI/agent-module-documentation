#!/usr/bin/env bash
# Execution RESET: ensure an article node titled 'NE Export Probe' exists and remove the target
# export file so verify fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","NE Export Probe")->range(0,1)->execute();
  if (empty($ids)) { Node::create(["type"=>"article","title"=>"NE Export Probe"])->save(); }
  $p = DRUPAL_ROOT . "/sites/default/files/ne_export_probe.json";
  if (file_exists($p)) { unlink($p); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node 'NE Export Probe' present, export file removed"
