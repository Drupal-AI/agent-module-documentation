#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fh_token's component in the default form display uses the
# Field Hidden string widget (field_hidden_string_textfield). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_fh_token") : NULL;
  $type = $c["type"] ?? "none";
  print (($type === "field_hidden_string_textfield") ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
