#!/usr/bin/env bash
# Execution VERIFY: PASS when block barl_task_footer exists in Olivero's footer_bottom region,
# uses the "Powered by Drupal" plugin, and carries block_aria_landmark_roles third-party
# settings role="contentinfo" and label="Site information".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("barl_task_footer");
  $role = $b ? $b->getThirdPartySetting("block_aria_landmark_roles", "role") : NULL;
  $label = $b ? $b->getThirdPartySetting("block_aria_landmark_roles", "label") : NULL;
  $ok = $b
    && $b->getTheme() === "olivero"
    && $b->getRegion() === "footer_bottom"
    && $b->get("plugin") === "system_powered_by_block"
    && $role === "contentinfo"
    && $label === "Site information";
  print ($ok ? "PASS" : "FAIL")
    . " plugin=" . ($b ? $b->get("plugin") : "none")
    . " theme=" . ($b ? $b->getTheme() : "none")
    . " region=" . ($b ? $b->getRegion() : "none")
    . " role=" . var_export($role, TRUE) . " label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
