#!/usr/bin/env bash
# Execution RESET: ensure content type cecsv_doc exists with one published node "Cecsv Hard Node",
# and delete any prior export at public://cecsv_export.csv so verify FAILS until the agent builds it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  if (!NodeType::load("cecsv_doc")) { NodeType::create(["type" => "cecsv_doc", "name" => "CECSV Doc"])->save(); }
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "cecsv_doc", "title" => "Cecsv Hard Node"]);
  if (!$nodes) { Node::create(["type" => "cecsv_doc", "title" => "Cecsv Hard Node", "status" => 1])->save(); }
  $fs = \Drupal::service("file_system");
  $p = $fs->realpath("public://") . "/cecsv_export.csv";
  if (file_exists($p)) { unlink($p); }
' >/dev/null 2>&1
echo "reset: cecsv_doc + published node present; public://cecsv_export.csv removed"
