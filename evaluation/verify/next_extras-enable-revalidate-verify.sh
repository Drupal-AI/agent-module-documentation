#!/usr/bin/env bash
# next_extras execution VERIFY: PASS when node.article has next_extras.revalidate === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\next\Entity\NextEntityTypeConfig;
  $c = NextEntityTypeConfig::load("node.article");
  if (!$c) { print "FAIL no-config\n"; return; }
  $r = $c->getThirdPartySetting("next_extras", "revalidate");
  print (($r === TRUE) ? "PASS" : "FAIL") . " revalidate=" . var_export($r, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
