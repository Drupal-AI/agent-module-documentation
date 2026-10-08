#!/usr/bin/env bash
# Introspection SETUP: put items into the unique queue qu_known, including a duplicate that
# gets rejected, leaving exactly 2 items for the agent to count on the live site.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $q = \Drupal::service("queue_unique.database")->get("qu_known");
  $q->createQueue();
  // clear any stale rows for a deterministic count
  \Drupal::database()->delete("queue_unique")->condition("name","qu_known")->execute();
  $q->createItem(["alpha"]);
  $q->createItem(["alpha"]); // duplicate -> rejected
  $q->createItem(["beta"]);
' >/dev/null 2>&1
echo "setup: unique queue qu_known has 2 items (one duplicate rejected)"
