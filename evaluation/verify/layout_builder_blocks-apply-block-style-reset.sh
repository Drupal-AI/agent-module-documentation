#!/usr/bin/env bash
# HARD execution reset: prepare a target Article node whose Layout Builder override holds a
# block WITHOUT any Layout Builder Blocks styling. On this state verify FAILS. It PASSES only
# after the agent applies a Bootstrap Styles class to a block in that node's layout so the block
# renders with the class. Enables the Article LB override and clears any stale target/config.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->enableLayoutBuilder()->setOverridable(TRUE)->save();
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "LBB Build Target"]) as $n) { $n->delete(); }
  $node = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "LBB Build Target"]);
  $node->save();
  $section = new \Drupal\layout_builder\Section("layout_onecol");
  // A plain block, deliberately WITHOUT bootstrap_styles.
  $comp = new \Drupal\layout_builder\SectionComponent(\Drupal::service("uuid")->generate(), "content", [
    "id" => "system_powered_by_block", "label" => "Powered by", "label_display" => "0", "provider" => "system",
  ]);
  $section->appendComponent($comp);
  $node->get("layout_builder__layout")->setValue([$section]);
  $node->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node 'LBB Build Target' created with an unstyled block; Article LB override on"
