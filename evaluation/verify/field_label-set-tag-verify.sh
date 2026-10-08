#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fl_target component of node.article.default has
# third_party_settings.field_label.label_tag === 'h3'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $d ? $d->getComponent("field_fl_target") : NULL;
  $v = $c["third_party_settings"]["field_label"]["label_tag"] ?? NULL;
  print (($v === "h3") ? "PASS" : "FAIL") . " label_tag=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
