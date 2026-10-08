#!/usr/bin/env bash
# Execution VERIFY (video_embed_facebook): PASS when a node 'vef_show' stores the target Facebook
# video (id 555000111) in field_vef_show. Reads the raw value only (no provider class load).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $val = "";
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_show"]) as $n){
    if ($n->hasField("field_vef_show")) { $val = (string) $n->get("field_vef_show")->value; }
  }
  $ok = (strpos($val, "facebook.com") !== FALSE) && (strpos($val, "555000111") !== FALSE);
  print ($ok?"PASS":"FAIL")." value=[".$val."]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
