#!/usr/bin/env bash
# Introspection SETUP: enable content_entity_clone for node.article with a clone label 'Duplicate'
# and a fields map (title -> entity_label_clone_suffix, body -> copy_values). Lets an agent read
# back which bundle has cloning enabled and its field processors. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("content_entity_clone.bundle.settings.node.article")
    ->set("enabled", TRUE)
    ->set("langcode", "en")
    ->set("local_task_label", "Duplicate")
    ->set("fields", [
      "title" => ["processor" => ["id" => "entity_label_clone_suffix", "settings" => []]],
      "body"  => ["processor" => ["id" => "copy_values", "settings" => []]],
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content_entity_clone enabled for node.article (label Duplicate; title=entity_label_clone_suffix, body=copy_values)"
