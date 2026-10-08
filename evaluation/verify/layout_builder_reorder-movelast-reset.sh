#!/usr/bin/env bash
# Execution RESET: create node "LBR Move Node" with three sections in order
# [layout_onecol, layout_twocol_section, layout_threecol_section], so verify FAILS until the
# agent moves the one-column section to the LAST position. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  use Drupal\layout_builder\Section;
  if (!NodeType::load("lbr_reorder")) { NodeType::create(["type"=>"lbr_reorder","name"=>"LBR Reorder Test"])->save(); }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","lbr_reorder","default");
  if (!$vd->isLayoutBuilderEnabled()) { $vd->enableLayoutBuilder()->setOverridable(TRUE)->save(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"LBR Move Node"]) as $n) { $n->delete(); }
  $node = Node::create(["type"=>"lbr_reorder","title"=>"LBR Move Node"]);
  $node->get("layout_builder__layout")->setValue([new Section("layout_onecol"), new Section("layout_twocol_section"), new Section("layout_threecol_section")]);
  $node->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: LBR Move Node sections [layout_onecol, layout_twocol_section, layout_threecol_section]"
