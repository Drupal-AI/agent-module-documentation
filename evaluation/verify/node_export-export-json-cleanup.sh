#!/usr/bin/env bash
# Execution CLEANUP: remove the export file and the probe node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $p = DRUPAL_ROOT . "/sites/default/files/ne_export_probe.json";
  if (file_exists($p)) { unlink($p); }
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","NE Export Probe")->execute();
  foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: export file and NE Export Probe node removed"
