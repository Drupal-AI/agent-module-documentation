#!/usr/bin/env bash
# Execution VERIFY: PASS when node.type.nthht_recipe has a NON-EMPTY node_title_help_text
# title_help (any guidance text). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("nthht_recipe");
  $h = $t ? trim((string) $t->getThirdPartySetting("node_title_help_text","title_help")) : "";
  $ok = ($h !== "");
  print ($ok ? "PASS" : "FAIL") . " title_help=[" . $h . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
