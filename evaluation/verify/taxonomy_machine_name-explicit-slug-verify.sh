#!/usr/bin/env bash
# Execution VERIFY: PASS when a Tags term named "TMN Explicit Term" exists AND its
# taxonomy_machine_name machine_name property is exactly "tmn_custom_slug". exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $terms=\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"tags","name"=>"TMN Explicit Term"]);
  $mn=NULL;
  if ($terms){ $t=reset($terms); $mn=$t->get("machine_name")->value; }
  $ok=($mn==="tmn_custom_slug");
  print ($ok?"PASS":"FAIL")." machine_name=".var_export($mn,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
