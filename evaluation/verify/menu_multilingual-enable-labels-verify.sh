#!/usr/bin/env bash
# Execution VERIFY: PASS when block mm_task has menu_multilingual only_translated_labels === TRUE.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("mm_task");
  $v = $b ? $b->getThirdPartySetting("menu_multilingual", "only_translated_labels") : NULL;
  $ok = ($b && $v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " block=" . ($b ? "1" : "0") . " only_translated_labels=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
