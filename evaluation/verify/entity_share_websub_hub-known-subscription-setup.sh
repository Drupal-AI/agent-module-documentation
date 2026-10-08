#!/usr/bin/env bash
# Introspection SETUP: insert one known row into the hub subscription table so an inspecting
# agent can read back the subscriber_endpoint. Idempotent (delete-then-insert). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("entity_share_websub_hub_subscription")
     ->condition("subscriber_endpoint", "https://eswhub-example.test/subscription/known-key-123")
     ->execute();
  $db->insert("entity_share_websub_hub_subscription")->fields([
    "subscriber_endpoint" => "https://eswhub-example.test/subscription/known-key-123",
    "user_email" => "sub@eswhub-example.test",
    "entity_type" => "node",
    "entity_id" => "1111aaaa-2222-bbbb-3333-cccc4444dddd",
    "status" => 1, "update_flag" => 0, "is_verified" => 1,
    "subscriber_secret" => "eswhub_secret", "content_summary" => "Known Article : article",
    "uid" => 1, "channel_id" => "eswhub_channel",
  ])->execute();
' >/dev/null 2>&1
echo "setup: inserted subscription subscriber_endpoint=https://eswhub-example.test/subscription/known-key-123"
