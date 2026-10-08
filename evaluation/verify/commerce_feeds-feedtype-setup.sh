#!/usr/bin/env bash
# Introspection SETUP: create a Feeds feed type that uses the Commerce Feeds product
# processor, so an inspecting agent can read back its processor plugin id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\feeds\Entity\FeedType;
  if (!FeedType::load("cf_med")) {
    FeedType::create([
      "id" => "cf_med", "label" => "CF Medium Products",
      "fetcher" => "upload",
      "fetcher_configuration" => ["allowed_extensions" => "csv txt", "directory" => "public://feeds"],
      "parser" => "csv", "parser_configuration" => [],
      "processor" => "entity:commerce_product",
      "processor_configuration" => ["values" => ["type" => "default"], "authorize" => TRUE, "update_existing" => 0, "update_non_existent" => "_keep", "expire" => -1, "skip_hash_check" => FALSE],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: feeds.feed_type.cf_med uses processor entity:commerce_product"
