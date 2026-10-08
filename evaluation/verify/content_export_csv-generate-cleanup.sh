#!/usr/bin/env bash
# Execution CLEANUP: delete the cecsv_doc nodes + content type and the export file. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["type" => "cecsv_doc"]) as $n) { $n->delete(); }
  if ($t = NodeType::load("cecsv_doc")) { $t->delete(); }
  $p = \Drupal::service("file_system")->realpath("public://") . "/cecsv_export.csv";
  if (file_exists($p)) { unlink($p); }
' >/dev/null 2>&1
echo "cleanup: cecsv_doc type/nodes and export file removed"
