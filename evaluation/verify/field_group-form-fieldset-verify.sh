#!/usr/bin/env bash
# Live-state verification for the "Article form: fieldset group containing >= 2 fields" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the node.article.default entity_FORM_display has a field_group third-party
# setting keyed `group_eval_fieldset` whose format_type is `fieldset` AND whose children
# include at least 2 fields.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $g = $d ? $d->getThirdPartySetting("field_group", "group_eval_fieldset") : NULL;
  $exists = is_array($g);
  $format = $exists && isset($g["format_type"]) ? $g["format_type"] : "";
  $isFieldset = $format === "fieldset";
  $children = ($exists && isset($g["children"]) && is_array($g["children"])) ? $g["children"] : [];
  $enough = count($children) >= 2;
  $ok = $exists && $isFieldset && $enough;
  print ($ok ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0)
    . " format_type=" . ($format!==""?$format:"-")
    . " child_count=" . count($children)
    . " children=" . implode(",", $children) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
