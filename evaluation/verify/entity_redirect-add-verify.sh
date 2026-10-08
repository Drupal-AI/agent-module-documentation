#!/usr/bin/env bash
# Execution VERIFY: PASS when node.er_task has Entity Redirect configured so the ADD action is
# active with destination 'add_form'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("er_task");
  $r = $t ? $t->getThirdPartySetting("entity_redirect", "redirect", []) : [];
  $add = $r["add"] ?? [];
  $active = $add["active"] ?? NULL;
  $isTrue = ($active === TRUE || $active === 1 || $active === "1");
  $ok = $isTrue && (($add["destination"] ?? NULL) === "add_form");
  print ($ok ? "PASS" : "FAIL") . " active=" . var_export($active, TRUE) . " destination=" . var_export($add["destination"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
