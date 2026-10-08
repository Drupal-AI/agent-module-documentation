#!/usr/bin/env bash
# HARD execution cleanup: delete the target node and disable the Article LB override so the site
# returns to baseline after the execution case runs.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "LBB Build Target"]) as $n) { $n->delete(); }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($d && $d->getThirdPartySetting("layout_builder", "enabled")) {
    $d->disableLayoutBuilder()->setThirdPartySetting("layout_builder", "allow_custom", FALSE)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: build target deleted, Article LB override disabled"
