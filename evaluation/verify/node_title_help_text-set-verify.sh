#!/usr/bin/env bash
# Execution VERIFY: PASS when node.type.nthht_task has node_title_help_text.title_help exactly
# equal to the requested sentence. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("nthht_task");
  $h = $t ? (string) $t->getThirdPartySetting("node_title_help_text","title_help") : "";
  $ok = (trim($h) === "Enter a short, descriptive title of at most 60 characters.");
  print ($ok ? "PASS" : "FAIL") . " title_help=[" . $h . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
