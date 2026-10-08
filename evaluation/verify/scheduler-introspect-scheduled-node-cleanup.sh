#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline after the "which Article is scheduled" case —
# delete the known scheduled node and turn Scheduler off for the Article content type.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "Eval Scheduled Announcement")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $type->setThirdPartySetting("scheduler", "publish_enable", FALSE);
    $type->setThirdPartySetting("scheduler", "unpublish_enable", FALSE);
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed 'Eval Scheduled Announcement' + scheduler disabled on article"
