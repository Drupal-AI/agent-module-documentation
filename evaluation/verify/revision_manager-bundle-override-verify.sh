#!/usr/bin/env bash
# Execution VERIFY: PASS when node.type.article carries a revision_manager 'amount' third-party
# setting keeping a minimum of 10 revisions. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $nt = NodeType::load("article");
  $tp = $nt ? $nt->getThirdPartySetting("revision_manager", "amount") : NULL;
  $count = is_array($tp) ? ($tp["settings"]["amount"] ?? NULL) : NULL;
  $ok = is_array($tp) && ((int) $count === 10);
  print ($ok ? "PASS" : "FAIL") . " override=" . (is_array($tp) ? "yes" : "no") . " amount=" . var_export($count, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
