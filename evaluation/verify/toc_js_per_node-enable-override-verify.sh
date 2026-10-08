#!/usr/bin/env bash
# Execution VERIFY: PASS when content type tocjspn_page has toc_js_per_node.override === TRUE. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("tocjspn_page");
  if (!$t) { print "FAIL no-type\n"; return; }
  $o = $t->getThirdPartySetting("toc_js_per_node","override",FALSE);
  print (($o === TRUE) ? "PASS" : "FAIL") . " override=" . var_export($o, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
