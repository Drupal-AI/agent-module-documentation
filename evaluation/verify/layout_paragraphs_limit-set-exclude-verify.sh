#!/usr/bin/env bash
# Execution VERIFY: PASS when layout_paragraphs_limit.settings excludes bp_callout from the
# content region of layout_onecol (paragraph_types contains bp_callout, negate not truthy).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::config("layout_paragraphs_limit.settings")->get("disallowed_types.layout_onecol.content");
  $types = $r["paragraph_types"] ?? [];
  $has = !empty($types["bp_callout"]);
  $negate = !empty($r["negate"]);
  print (($has && !$negate) ? "PASS" : "FAIL")." has_bp_callout=".var_export($has,TRUE)." negate=".var_export($negate,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
