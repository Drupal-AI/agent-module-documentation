#!/usr/bin/env bash
# MEDIUM introspection cleanup: delete the target node and disable the Layout Builder override
# on the Article display so the site returns to baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "LBB Introspect Target"]) as $n) { $n->delete(); }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($d && $d->getThirdPartySetting("layout_builder", "enabled")) {
    $d->disableLayoutBuilder()->setThirdPartySetting("layout_builder", "allow_custom", FALSE)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: target node deleted, Article LB override disabled"
