#!/usr/bin/env bash
# Reset Scheduler to a clean, known baseline between eval runs so each condition is
# independent: delete every node titled like "Eval Scheduled Post%", and turn Scheduler
# off for the Article content type (publish_enable/unpublish_enable = FALSE via the
# scheduler third-party settings on node.type.article).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "Eval Scheduled Post%", "LIKE")->execute();
  if ($ids) {
    $storage = \Drupal::entityTypeManager()->getStorage("node");
    $storage->delete($storage->loadMultiple($ids));
  }
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $type->setThirdPartySetting("scheduler", "publish_enable", FALSE);
    $type->setThirdPartySetting("scheduler", "unpublish_enable", FALSE);
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: scheduler disabled on article + Eval Scheduled Post nodes removed"
