#!/usr/bin/env bash
# next_extras execution VERIFY: PASS when node.page has next_extras.revalidate===TRUE AND revalidate_paths==='/news'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\next\Entity\NextEntityTypeConfig;
  $c = NextEntityTypeConfig::load("node.page");
  if (!$c) { print "FAIL no-config\n"; return; }
  $r = $c->getThirdPartySetting("next_extras", "revalidate");
  $p = $c->getThirdPartySetting("next_extras", "revalidate_paths");
  $ok = ($r === TRUE) && ($p === "/news");
  print ($ok ? "PASS" : "FAIL") . " revalidate=" . var_export($r, TRUE) . " paths=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
