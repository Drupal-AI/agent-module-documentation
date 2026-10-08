#!/usr/bin/env bash
# Execution VERIFY: PASS when block.block.cf_task exists with plugin copyright_footer and
# settings.organization_name === 'Copyright Test Org'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("cf_task");
  $plugin = $b ? $b->getPluginId() : "none";
  $org = $b ? ($b->get("settings")["organization_name"] ?? "") : "";
  $ok = ($b && $plugin === "copyright_footer" && $org === "Copyright Test Org");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " org=" . var_export($org, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
