#!/usr/bin/env bash
# Execution VERIFY for "make the whole fgl_teaser group a link to the node itself".
# PASS when core.entity_view_display.node.article.fgl_teaser carries a field_group group whose
# format_type is 'link' (the field_group_link formatter), whose format_settings.target is
# 'entity' (link at the rendered entity's own canonical URL rather than a field or custom URI)
# and which contains field_fgl_teaser_text among its children.
# The group's machine name is deliberately NOT pinned — the prompt does not dictate one.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.fgl_teaser");
  $groups = $vd ? $vd->getThirdPartySettings("field_group") : [];
  $match = NULL;
  $target = NULL;
  foreach ($groups as $name => $g) {
    if (($g["format_type"] ?? NULL) === "link"
      && in_array("field_fgl_teaser_text", $g["children"] ?? [], TRUE)) {
      $match = $name;
      $target = $g["format_settings"]["target"] ?? NULL;
      if ($target === "entity") { break; }
    }
  }
  $ok = ($match !== NULL) && ($target === "entity");
  print ($ok ? "PASS" : "FAIL")
    . " display=" . ($vd ? "present" : "MISSING")
    . " group=" . var_export($match, TRUE)
    . " target=" . var_export($target, TRUE)
    . " all_groups=[" . implode("|", array_keys($groups)) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
