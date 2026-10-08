#!/usr/bin/env bash
# Execution VERIFY: PASS when user form entitygroupfield component exists with type entitygroupfield_autocomplete_widget.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  $c=$fd?$fd->getComponent("entitygroupfield"):NULL;
  $t=$c["type"]??NULL;
  print (($t==="entitygroupfield_autocomplete_widget")?"PASS":"FAIL")." type=".var_export($t,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
