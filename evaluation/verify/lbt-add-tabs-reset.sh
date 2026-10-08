#!/usr/bin/env bash
# Execution RESET: create lbt_demo, enable Layout Builder on its default view display, and force a
# single non-tabs section (layout_onecol) so verify FAILS until the agent adds a Tabs section.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\layout_builder\Section;
  if (!NodeType::load("lbt_demo")) { NodeType::create(["type"=>"lbt_demo","name"=>"LBT Demo"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.lbt_demo.default") ?: $s->create(["targetEntityType"=>"node","bundle"=>"lbt_demo","mode"=>"default","status"=>TRUE]);
  $d->enableLayoutBuilder();
  foreach (array_keys($d->getSections()) as $i) { $d->removeSection(0); }
  $d->appendSection(new Section("layout_onecol"));
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.lbt_demo default display has one layout_onecol section, no tabs"
