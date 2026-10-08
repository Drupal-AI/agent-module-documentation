#!/usr/bin/env bash
# Execution VERIFY: PASS when block_classes_split has title_class "visually-hidden" and
# content_class containing both "grid" and "grid--3col". exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("block_classes_split");
  $t = $b ? (string) $b->getThirdPartySetting("block_classes", "title_class") : "";
  $c = $b ? (string) $b->getThirdPartySetting("block_classes", "content_class") : "";
  $tp = preg_split("/\s+/", trim($t), -1, PREG_SPLIT_NO_EMPTY);
  $cp = preg_split("/\s+/", trim($c), -1, PREG_SPLIT_NO_EMPTY);
  $ok = $b && in_array("visually-hidden", $tp, TRUE)
     && in_array("grid", $cp, TRUE) && in_array("grid--3col", $cp, TRUE);
  print ($ok ? "PASS" : "FAIL") . " title_class=" . var_export($t, TRUE) . " content_class=" . var_export($c, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
