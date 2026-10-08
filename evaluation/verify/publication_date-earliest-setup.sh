#!/usr/bin/env bash
# Introspection SETUP: create TWO known published Articles with different publication_date
# (published_at) timestamps so the agent must read the field to tell which was published
# first:
#   'PD First Post'  -> published_at 1514808000 (2018-01-01)  <-- earliest
#   'PD Second Post' -> published_at 1656936000 (2022-07-04)
# Idempotent: removes any prior copies first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", ["PD First Post", "PD Second Post"], "IN")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  foreach ([["PD First Post", 1514808000], ["PD Second Post", 1656936000]] as $row) {
    $n = \Drupal\node\Entity\Node::create(["type" => "article", "title" => $row[0], "status" => 1]);
    $n->set("published_at", $row[1]);
    $n->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: 'PD First Post' (2018) + 'PD Second Post' (2022) published Articles"
