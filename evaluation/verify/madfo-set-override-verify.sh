#!/usr/bin/env bash
# Execution VERIFY: PASS when media 'MAD Override Task' has field_override_mad_module truthy. 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ms = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MAD Override Task"]);
  $m = $ms ? reset($ms) : NULL;
  $v = $m ? $m->get("field_override_mad_module")->value : NULL;
  $ok = ($m && !empty($v));
  print ($ok ? "PASS" : "FAIL") . " media=" . ($m ? $m->id() : "0") . " override=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
