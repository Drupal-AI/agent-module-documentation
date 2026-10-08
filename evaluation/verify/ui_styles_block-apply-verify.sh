#!/usr/bin/env bash
# Execution VERIFY (ui_styles_block): PASS when block.block.ui_styles_eval_block has the CSS
# class 'ui-styles-eval-applied' in ANY of its ui_styles parts (selected values or extra).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $block = Block::load("ui_styles_eval_block");
  $found = FALSE;
  if ($block) {
    foreach ($block->getThirdPartySettings("ui_styles") as $part) {
      $classes = \array_merge(\array_values($part["selected"] ?? []), \explode(" ", (string) ($part["extra"] ?? "")));
      if (\in_array("ui-styles-eval-applied", $classes, TRUE)) { $found = TRUE; }
    }
  }
  print ($found ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
