#!/usr/bin/env bash
# Execution VERIFY: PASS when "NKT Task" has keeper_machine_name === "nkt_task". exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $n = ($x = $s->loadByProperties(["title" => "NKT Task"])) ? reset($x) : NULL;
  $v = $n ? $n->get("keeper_machine_name")->value : NULL;
  print (($v === "nkt_task") ? "PASS" : "FAIL") . " keeper_machine_name=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
