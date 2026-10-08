#!/usr/bin/env bash
# MEDIUM introspection SETUP: enable stripe_examples and place its example checkout block
# (id stripe_ex_probe) so an agent can read the block plugin back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en stripe_examples -y >/dev/null 2>&1
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if (!Block::load("stripe_ex_probe")) {
    Block::create([
      "id" => "stripe_ex_probe", "plugin" => "stripe_example_checkout", "region" => "content",
      "theme" => $theme, "weight" => 0, "status" => TRUE,
      "settings" => ["id" => "stripe_example_checkout", "label" => "Checkout", "label_display" => "0"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: stripe_examples enabled, block stripe_ex_probe (stripe_example_checkout) placed"
