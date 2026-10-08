#!/usr/bin/env bash
# Introspection SETUP: enable Scheduler on Article and create a KNOWN scheduled Article so an
# inspecting agent (drush) can read back its title / scheduled publish time. The node is
# unpublished with a publish_on timestamp 5 days in the future and a distinctive title.
# Idempotent: removes any prior copy of the known node first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $type->setThirdPartySetting("scheduler", "publish_enable", TRUE);
    $type->setThirdPartySetting("scheduler", "unpublish_enable", TRUE);
    $type->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  // Remove our known node and any other eval-created scheduled article so exactly ONE
  // future-scheduled Article (ours) exists and the introspection answer is unambiguous.
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "Eval Scheduled %", "LIKE")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  $when = \Drupal::time()->getRequestTime() + (5 * 86400);
  $node = \Drupal\node\Entity\Node::create([
    "type" => "article",
    "title" => "Eval Scheduled Announcement",
    "status" => 0,
    "publish_on" => $when,
  ]);
  $node->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: unpublished Article 'Eval Scheduled Announcement' scheduled to publish in ~5 days"
