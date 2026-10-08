#!/usr/bin/env bash
# Execution VERIFY: PASS when simple_block sb_task exists with a non-empty title and content.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\simple_block\Entity\SimpleBlock;
  $b = SimpleBlock::load("sb_task");
  if (!$b) { print "FAIL sb_task missing\n"; return; }
  $title = (string) $b->label();
  $val = (string) ($b->getContent()["value"] ?? "");
  $ok = ($title !== "" && $val !== "");
  print ($ok ? "PASS" : "FAIL") . " title=" . var_export($title, TRUE) . " content_len=" . strlen($val) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
