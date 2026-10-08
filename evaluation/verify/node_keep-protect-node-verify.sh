#!/usr/bin/env bash
# Execution VERIFY: PASS when the "NK Task Node" Article has node_keeper truthy. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $nodes = $s->loadByProperties(["title" => "NK Task Node"]);
  $n = $nodes ? reset($nodes) : NULL;
  $v = $n ? $n->get("node_keeper")->value : NULL;
  $ok = !empty($v);
  print ($ok ? "PASS" : "FAIL") . " node_keeper=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
