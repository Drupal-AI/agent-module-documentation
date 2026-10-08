#!/usr/bin/env bash
# Execution VERIFY for "enable Hide seconds on the field_dhs_period Datetime Range widget".
# PASS when the field's component in core.entity_form_display.node.article.default carries
# third_party_settings.datetimehideseconds.hide === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_dhs_period") : NULL;
  $hide = $c["third_party_settings"]["datetimehideseconds"]["hide"] ?? NULL;
  $ok = ($hide === TRUE);
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . " hide=" . var_export($hide, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
