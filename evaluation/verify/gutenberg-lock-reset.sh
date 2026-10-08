#!/usr/bin/env bash
# Execution RESET: create a namespaced Gutenberg-enabled content type WITHOUT a template lock, so
# a "lock the block template" task fails until performed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("gutenberg_lock")) { NodeType::create(["type" => "gutenberg_lock", "name" => "Gutenberg Lock"])->save(); }
  \Drupal::configFactory()->getEditable("gutenberg.settings")
    ->set("gutenberg_lock_enable_full", TRUE)
    ->clear("gutenberg_lock_template_lock")
    ->save();
' >/dev/null 2>&1
echo "reset: gutenberg_lock enabled, no template lock"
