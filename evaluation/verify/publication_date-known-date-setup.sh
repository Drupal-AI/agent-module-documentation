#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN published Article whose publication_date
# (published_at) is set to a fixed timestamp (1625400000 = 2021-07-04 12:00:00 UTC) so an
# inspecting agent (drush) can read back its publication year/date. Distinctive title.
# Idempotent: removes any prior copy first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "PD Known Post")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  $node = \Drupal\node\Entity\Node::create([
    "type" => "article",
    "title" => "PD Known Post",
    "status" => 1,
  ]);
  $node->set("published_at", 1625400000);
  $node->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: published Article 'PD Known Post' with published_at=1625400000 (2021-07-04)"
