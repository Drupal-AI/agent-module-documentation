#!/usr/bin/env bash
# Introspection CLEANUP: delete the cecsv_survey content type. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "cecsv_survey"]) as $n) { $n->delete(); }
  if ($t = NodeType::load("cecsv_survey")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: cecsv_survey content type removed"
