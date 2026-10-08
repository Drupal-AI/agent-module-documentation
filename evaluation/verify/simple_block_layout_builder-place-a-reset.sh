#!/usr/bin/env bash
# Execution RESET: sblb_h1 LB-enabled empty, block sblb_a absent so verify FAILS until placed.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\simple_block\Entity\SimpleBlock;
  if ($nt = NodeType::load("sblb_h1")) { $nt->delete(); }
  NodeType::create(["type" => "sblb_h1", "name" => "sblb_h1"])->save();
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $s->load("node.sblb_h1.default");
  if (!$vd) { $vd = $s->create(["targetEntityType" => "node", "bundle" => "sblb_h1", "mode" => "default", "status" => TRUE]); }
  $vd->enableLayoutBuilder()->save();
  if ($b = SimpleBlock::load("sblb_a")) { $b->delete(); }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "reset: node.sblb_h1 LB-enabled empty layout, simple_block sblb_a absent"
