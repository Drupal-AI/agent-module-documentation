#!/usr/bin/env bash
# Live-state verification for the "Article form: details group group_eval_meta with Body inside" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the node.article.default entity_form_display has a field_group third-party
# setting keyed `group_eval_meta` whose format_type is a details-like group AND whose
# children include `body`.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $g = $d ? $d->getThirdPartySetting("field_group", "group_eval_meta") : NULL;
  $exists = is_array($g);
  $format = $exists && isset($g["format_type"]) ? $g["format_type"] : "";
  $isDetails = in_array($format, ["details", "details_sidebar"], TRUE);
  $children = ($exists && isset($g["children"]) && is_array($g["children"])) ? $g["children"] : [];
  $hasBody = in_array("body", $children, TRUE);
  $ok = $exists && $isDetails && $hasBody;
  print ($ok ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0)
    . " format_type=" . ($format!==""?$format:"-")
    . " has_body=" . ($hasBody?1:0)
    . " children=" . implode(",", $children) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
