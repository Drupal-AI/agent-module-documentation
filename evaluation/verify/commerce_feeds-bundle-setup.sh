#!/usr/bin/env bash
# Introspection SETUP: create a product-importing feed type whose processor is configured to
# create products of the "default" product type, so an agent can read back the target bundle.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\feeds\Entity\FeedType;
  if (!FeedType::load("cf_med2")) {
    FeedType::create([
      "id" => "cf_med2", "label" => "CF Bundle Products",
      "fetcher" => "upload",
      "fetcher_configuration" => ["allowed_extensions" => "csv txt", "directory" => "public://feeds"],
      "parser" => "csv", "parser_configuration" => [],
      "processor" => "entity:commerce_product",
      "processor_configuration" => ["values" => ["type" => "default"], "authorize" => TRUE, "update_existing" => 0, "update_non_existent" => "_keep", "expire" => -1, "skip_hash_check" => FALSE],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: feeds.feed_type.cf_med2 processor_configuration.values.type=default"
