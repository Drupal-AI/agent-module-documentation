#!/usr/bin/env bash
# Execution VERIFY: PASS when userid == AIOA-LIVE-9090 AND position == top_left. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c=\Drupal::config("all_in_one_accessibility.userid.settings");
  $u=$c->get("userid"); $p=$c->get("position");
  $ok = ($u === "AIOA-LIVE-9090") && ($p === "top_left");
  print ($ok?"PASS":"FAIL")." userid=".var_export($u,TRUE)." position=".var_export($p,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
