#!/usr/bin/env bash
# Execution VERIFY: PASS when [node-keep:nkt_render:id] replaces to the "NKT Render" node's nid. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $n = ($x = $s->loadByProperties(["title" => "NKT Render"])) ? reset($x) : NULL;
  $nid = $n ? (string) $n->id() : "none";
  $rendered = \Drupal::token()->replace("[node-keep:nkt_render:id]", [], ["clear" => TRUE]);
  $ok = ($n && $rendered === $nid);
  print ($ok ? "PASS" : "FAIL") . " nid=" . $nid . " rendered=" . var_export($rendered, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
