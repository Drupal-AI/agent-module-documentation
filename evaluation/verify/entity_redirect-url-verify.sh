#!/usr/bin/env bash
# Execution VERIFY: PASS when node.er_task2 has Entity Redirect configured so the EDIT action is
# active with destination 'url' pointing at /er-done. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("er_task2");
  $r = $t ? $t->getThirdPartySetting("entity_redirect", "redirect", []) : [];
  $edit = $r["edit"] ?? [];
  $active = $edit["active"] ?? NULL;
  $isTrue = ($active === TRUE || $active === 1 || $active === "1");
  $ok = $isTrue && (($edit["destination"] ?? NULL) === "url") && (($edit["url"] ?? NULL) === "/er-done");
  print ($ok ? "PASS" : "FAIL") . " active=" . var_export($active, TRUE) . " destination=" . var_export($edit["destination"] ?? NULL, TRUE) . " url=" . var_export($edit["url"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
