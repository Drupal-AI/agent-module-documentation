#!/usr/bin/env bash
# Execution VERIFY: PASS when block barl_task_menu carries block_aria_landmark_roles
# third-party settings role="navigation" and label="Primary navigation".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("barl_task_menu");
  $role = $b ? $b->getThirdPartySetting("block_aria_landmark_roles", "role") : NULL;
  $label = $b ? $b->getThirdPartySetting("block_aria_landmark_roles", "label") : NULL;
  $ok = $b && $role === "navigation" && $label === "Primary navigation";
  print ($ok ? "PASS" : "FAIL") . " block=" . ($b ? "yes" : "no")
    . " role=" . var_export($role, TRUE) . " label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
