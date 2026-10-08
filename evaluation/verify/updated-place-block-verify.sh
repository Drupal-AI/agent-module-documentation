#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled Last Updated date block (plugin updated_date_block) is
# placed in the default theme. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default");
  $found = FALSE; $id = "none";
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "updated_date_block" && $b->getTheme() === $theme && $b->status()) { $found = TRUE; $id = $b->id(); break; }
  }
  print ($found ? "PASS" : "FAIL") . " theme=$theme block=$id\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
