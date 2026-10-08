#!/usr/bin/env bash
# Introspection CLEANUP: remove the known subscription row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("entity_share_websub_hub_subscription")
    ->condition("subscriber_endpoint", "https://eswhub-example.test/subscription/known-key-123")
    ->execute();
' >/dev/null 2>&1
echo "cleanup: known subscription row removed"
