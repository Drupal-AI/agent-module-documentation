#!/usr/bin/env bash
# Execution RESET: ensure lbt_demo exists with Layout Builder DISABLED on its default view display,
# so verify FAILS until the agent enables Layout Builder and adds a Tabs section. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("lbt_demo")) { NodeType::create(["type"=>"lbt_demo","name"=>"LBT Demo"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.lbt_demo.default") ?: $s->create(["targetEntityType"=>"node","bundle"=>"lbt_demo","mode"=>"default","status"=>TRUE]);
  if ($d->isLayoutBuilderEnabled()) { $d->disableLayoutBuilder(); }
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.lbt_demo default display has Layout Builder DISABLED"
