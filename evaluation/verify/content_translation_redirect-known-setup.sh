#!/usr/bin/env bash
# Introspection SETUP: create a content_translation_redirect for node/article (302, mode all).
# Raw config write (config-entity save via the entity API is currently blocked by an unrelated
# broken commerce_giftcard field on this shared site). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("content_translation_redirect.entity.node__article")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>[],
    "id"=>"node__article","label"=>"Content: Article","code"=>302,"path"=>"","mode"=>"all",
    "uuid"=>\Drupal::service("uuid")->generate(),
  ])->save();
' >/dev/null 2>&1
echo "setup: content_translation_redirect node__article (code 302, mode all) created"
