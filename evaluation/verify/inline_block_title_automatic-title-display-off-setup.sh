#!/usr/bin/env bash
# Introspection SETUP: ibta_m2 with Layout Builder enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("ibta_m2")) { NodeType::create(["type" => "ibta_m2", "name" => "ibta_m2"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $s->load("node.ibta_m2.default");
  if (!$vd) { $vd = $s->create(["targetEntityType" => "node", "bundle" => "ibta_m2", "mode" => "default", "status" => TRUE]); }
  $vd->enableLayoutBuilder()->setOverridable(FALSE)->save();
' >/dev/null 2>&1
echo "setup: node.ibta_m2 created with Layout Builder enabled"
