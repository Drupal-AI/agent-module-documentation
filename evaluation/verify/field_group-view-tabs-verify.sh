#!/usr/bin/env bash
# Live-state verification for the "Article view display: tabs container with a tab wrapping
# a field" task. Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the node.article.default entity_VIEW_display has:
#   - a field_group third-party setting `group_eval_vtabs` with format_type `tabs`, AND
#   - a field_group third-party setting `group_eval_vtab` with format_type `tab`, parented
#     to `group_eval_vtabs`, whose children include at least one field.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $tabs = $d ? $d->getThirdPartySetting("field_group", "group_eval_vtabs") : NULL;
  $tab  = $d ? $d->getThirdPartySetting("field_group", "group_eval_vtab") : NULL;
  $tabsOk = is_array($tabs) && ($tabs["format_type"] ?? "") === "tabs";
  $tabFmt = is_array($tab) ? ($tab["format_type"] ?? "") : "";
  $tabFmtOk = $tabFmt === "tab";
  $children = (is_array($tab) && isset($tab["children"]) && is_array($tab["children"])) ? $tab["children"] : [];
  $hasChild = count($children) >= 1;
  $parentOk = is_array($tab) && ($tab["parent_name"] ?? "") === "group_eval_vtabs";
  $ok = $tabsOk && $tabFmtOk && $hasChild && $parentOk;
  print ($ok ? "PASS" : "FAIL")
    . " tabs_exists=" . ($tabsOk?1:0)
    . " tab_format=" . ($tabFmt!==""?$tabFmt:"-")
    . " tab_parent=" . (is_array($tab) ? ($tab["parent_name"] ?? "-") : "-")
    . " tab_children=" . implode(",", $children) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
