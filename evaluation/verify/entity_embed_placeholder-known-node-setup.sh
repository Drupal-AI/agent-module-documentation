#!/usr/bin/env bash
# Introspection SETUP: create a known Article node that would be shown via the entity_embed
# placeholder preview, so an agent can inspect the site and report its title/type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $existing = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("title", "EEP Preview Node 9K2")->execute();
  if (empty($existing)) {
    Node::create(["type" => "article", "title" => "EEP Preview Node 9K2", "status" => 1])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Article node 'EEP Preview Node 9K2' created"
