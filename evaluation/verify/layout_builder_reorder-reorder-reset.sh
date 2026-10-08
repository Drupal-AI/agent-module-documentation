#!/usr/bin/env bash
# Execution RESET: ensure content type lbr_reorder (LB overrides) exists and create node
# "LBR Task Node" with sections [layout_onecol, layout_twocol_section] (one-column first), so
# verify FAILS until the agent moves the two-column section to the top. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  use Drupal\layout_builder\Section;
  if (!NodeType::load("lbr_reorder")) { NodeType::create(["type"=>"lbr_reorder","name"=>"LBR Reorder Test"])->save(); }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","lbr_reorder","default");
  if (!$vd->isLayoutBuilderEnabled()) { $vd->enableLayoutBuilder()->setOverridable(TRUE)->save(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"LBR Task Node"]) as $n) { $n->delete(); }
  $node = Node::create(["type"=>"lbr_reorder","title"=>"LBR Task Node"]);
  $node->get("layout_builder__layout")->setValue([new Section("layout_onecol"), new Section("layout_twocol_section")]);
  $node->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: LBR Task Node sections [layout_onecol, layout_twocol_section]"
