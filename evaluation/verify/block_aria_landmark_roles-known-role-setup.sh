#!/usr/bin/env bash
# Introspection SETUP: place a block (barl_eval_block) in Olivero and give it a known ARIA
# landmark role + label through block_aria_landmark_roles' third-party settings, so the agent
# must read the live block config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("barl_eval_block")) { $b->delete(); }
  $b = Block::create([
    "id" => "barl_eval_block", "theme" => "olivero", "region" => "sidebar", "weight" => 20,
    "plugin" => "system_powered_by_block",
    "settings" => [
      "id" => "system_powered_by_block", "label" => "BARL eval block",
      "label_display" => "visible", "provider" => "system",
    ],
    "visibility" => [],
  ]);
  $b->setThirdPartySetting("block_aria_landmark_roles", "role", "complementary");
  $b->setThirdPartySetting("block_aria_landmark_roles", "label", "Site extras");
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block barl_eval_block role=complementary label='Site extras'"
exit 0
