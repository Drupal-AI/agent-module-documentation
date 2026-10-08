#!/usr/bin/env bash
# Introspection SETUP: qu_alpha gets 1 item, qu_beta gets 3 items, so the agent must inspect
# the live unique queues to say which holds more.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::service("queue_unique.database");
  $a = $f->get("qu_alpha"); $a->createQueue();
  $b = $f->get("qu_beta");  $b->createQueue();
  $db = \Drupal::database();
  $db->delete("queue_unique")->condition("name","qu_alpha")->execute();
  $db->delete("queue_unique")->condition("name","qu_beta")->execute();
  $a->createItem(["only"]);
  $b->createItem(["one"]); $b->createItem(["two"]); $b->createItem(["three"]);
' >/dev/null 2>&1
echo "setup: qu_alpha=1 item, qu_beta=3 items"
