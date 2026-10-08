#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN *unpublished* Article. Because publication_date only
# stamps published_at on the first published save, this node's published_at stays NULL — the
# agent must inspect the running site and report that it has no publication date yet.
# Idempotent: removes any prior copy first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "PD Draft Post")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  $node = \Drupal\node\Entity\Node::create([
    "type" => "article",
    "title" => "PD Draft Post",
    "status" => 0,
  ]);
  $node->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: unpublished Article 'PD Draft Post' (published_at is NULL)"
