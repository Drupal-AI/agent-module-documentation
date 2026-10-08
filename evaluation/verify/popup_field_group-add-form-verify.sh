#!/usr/bin/env bash
# Execution VERIFY (popup_field_group): PASS when the Article default FORM display has at least
# one field group whose format_type === "popup". Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $hit = NULL;
  foreach ($fd->getThirdPartySettings("field_group") as $name => $g) {
    if (($g["format_type"] ?? NULL) === "popup") { $hit = $name; break; }
  }
  print ($hit ? "PASS group=" . $hit : "FAIL no popup group") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
