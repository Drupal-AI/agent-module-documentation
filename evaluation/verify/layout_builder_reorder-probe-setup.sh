#!/usr/bin/env bash
# Introspection SETUP: ensure a namespaced content type lbr_reorder exists with Layout Builder
# overrides enabled, and create a node "LBR Probe Node" whose override layout has two sections
# in order [layout_onecol, layout_twocol_section], so an agent can inspect the live section
# order. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  use Drupal\layout_builder\Section;
  if (!NodeType::load("lbr_reorder")) { NodeType::create(["type"=>"lbr_reorder","name"=>"LBR Reorder Test"])->save(); }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","lbr_reorder","default");
  if (!$vd->isLayoutBuilderEnabled()) { $vd->enableLayoutBuilder()->setOverridable(TRUE)->save(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"LBR Probe Node"]) as $n) { $n->delete(); }
  $node = Node::create(["type"=>"lbr_reorder","title"=>"LBR Probe Node"]);
  $node->get("layout_builder__layout")->setValue([new Section("layout_onecol"), new Section("layout_twocol_section")]);
  $node->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: LBR Probe Node has sections [layout_onecol, layout_twocol_section]"
