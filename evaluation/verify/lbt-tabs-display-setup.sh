#!/usr/bin/env bash
# Introspection SETUP: create the lbt_demo content type, enable Layout Builder on its default
# view display, and append a layout_builder_tabs "tabs" section, so an agent can read back which
# layout the section uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\layout_builder\Section;
  if (!NodeType::load("lbt_demo")) { NodeType::create(["type"=>"lbt_demo","name"=>"LBT Demo"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.lbt_demo.default") ?: $s->create(["targetEntityType"=>"node","bundle"=>"lbt_demo","mode"=>"default","status"=>TRUE]);
  $d->enableLayoutBuilder();
  // Reset to a single Tabs section.
  foreach (array_keys($d->getSections()) as $i) { $d->removeSection(0); }
  $d->appendSection(new Section("tabs"));
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.lbt_demo default display has a Layout Builder 'tabs' section"
