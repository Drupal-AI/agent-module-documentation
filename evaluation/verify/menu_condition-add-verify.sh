#!/usr/bin/env bash
# Execution VERIFY: PASS when block mc_hard has a menu_position visibility condition whose
# menu_parent targets the main menu (starts with 'main:'). Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("mc_hard");
  $v = $b ? $b->get("visibility") : [];
  $mp = $v["menu_position"]["menu_parent"] ?? NULL;
  $ok = (is_string($mp) && strpos($mp, "main:") === 0);
  print ($ok ? "PASS" : "FAIL") . " menu_parent=" . var_export($mp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
