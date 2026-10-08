#!/usr/bin/env bash
# Reset for the "schedule a Basic page to auto-unpublish" execution case to a clean, known
# baseline so each run is independent:
#   - ensure the Basic page (machine name `page`) content type EXISTS (create if missing) so
#     the task is purely about Scheduler, not about creating a content type;
#   - turn Scheduler OFF for the page type (publish_enable/unpublish_enable = FALSE);
#   - delete every node titled like "Eval Unpublish Page%".
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\node\Entity\NodeType::load("page")) {
    \Drupal\node\Entity\NodeType::create(["type" => "page", "name" => "Basic page"])->save();
  }
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "Eval Unpublish Page%", "LIKE")->execute();
  if ($ids) {
    $storage = \Drupal::entityTypeManager()->getStorage("node");
    $storage->delete($storage->loadMultiple($ids));
  }
  if ($type = \Drupal\node\Entity\NodeType::load("page")) {
    $type->setThirdPartySetting("scheduler", "publish_enable", FALSE);
    $type->setThirdPartySetting("scheduler", "unpublish_enable", FALSE);
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: page type present, scheduler disabled on page + Eval Unpublish Page nodes removed"
