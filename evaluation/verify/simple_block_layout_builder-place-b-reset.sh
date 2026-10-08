#!/usr/bin/env bash
# Execution RESET: sblb_h2 LB-enabled empty, block sblb_b absent so verify FAILS until placed.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\simple_block\Entity\SimpleBlock;
  if ($nt = NodeType::load("sblb_h2")) { $nt->delete(); }
  NodeType::create(["type" => "sblb_h2", "name" => "sblb_h2"])->save();
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $s->load("node.sblb_h2.default");
  if (!$vd) { $vd = $s->create(["targetEntityType" => "node", "bundle" => "sblb_h2", "mode" => "default", "status" => TRUE]); }
  $vd->enableLayoutBuilder()->save();
  if ($b = SimpleBlock::load("sblb_b")) { $b->delete(); }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "reset: node.sblb_h2 LB-enabled empty layout, simple_block sblb_b absent"
