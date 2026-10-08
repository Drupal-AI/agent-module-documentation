#!/usr/bin/env bash
# Introspection SETUP: place TWO blocks in Olivero — barl_eval_on with role "banner", and
# barl_eval_off with role explicitly set to "none" (plus an aria label on each) — so the agent
# must inspect the live config to work out which one actually renders a role attribute.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (["barl_eval_on" => ["banner", "Site header", 21], "barl_eval_off" => ["none", "Nothing special", 22]] as $id => $data) {
    if ($b = Block::load($id)) { $b->delete(); }
    $b = Block::create([
      "id" => $id, "theme" => "olivero", "region" => "sidebar", "weight" => $data[2],
      "plugin" => "system_powered_by_block",
      "settings" => [
        "id" => "system_powered_by_block", "label" => $id,
        "label_display" => "visible", "provider" => "system",
      ],
      "visibility" => [],
    ]);
    $b->setThirdPartySetting("block_aria_landmark_roles", "role", $data[0]);
    $b->setThirdPartySetting("block_aria_landmark_roles", "label", $data[1]);
    $b->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: barl_eval_on role=banner, barl_eval_off role=none"
exit 0
