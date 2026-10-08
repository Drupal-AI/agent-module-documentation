#!/usr/bin/env bash
# Execution VERIFY for "display field_df_faq as an HTML definition list".
# PASS when the field_df_faq component of core.entity_view_display.node.article.default uses the
# double_field_html_list formatter with list_type 'dl'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_df_faq") : NULL;
  $type = $c["type"] ?? "none";
  $lt = $c["settings"]["list_type"] ?? NULL;
  $ok = $type === "double_field_html_list" && $lt === "dl";
  print ($ok ? "PASS" : "FAIL")
    . " formatter=" . $type
    . " list_type=" . var_export($lt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
