#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one block config entity uses plugin
# domain_menus_active_domain_superfish_block with settings.menu_name === 'main'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $hit = NULL;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "domain_menus_active_domain_superfish_block") {
      $s = $b->get("settings");
      if (($s["menu_name"] ?? NULL) === "main") { $hit = $b->id(); break; }
    }
  }
  print ($hit ? "PASS block=" . $hit : "FAIL no main-menu superfish block") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
