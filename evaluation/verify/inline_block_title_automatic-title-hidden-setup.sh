#!/usr/bin/env bash
# Introspection SETUP: ibta_m1 with Layout Builder enabled so the inline-block add form can be inspected. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("ibta_m1")) { NodeType::create(["type" => "ibta_m1", "name" => "ibta_m1"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $s->load("node.ibta_m1.default");
  if (!$vd) { $vd = $s->create(["targetEntityType" => "node", "bundle" => "ibta_m1", "mode" => "default", "status" => TRUE]); }
  $vd->enableLayoutBuilder()->setOverridable(FALSE)->save();
' >/dev/null 2>&1
echo "setup: node.ibta_m1 created with Layout Builder enabled"
