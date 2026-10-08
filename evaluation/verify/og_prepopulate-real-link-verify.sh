#!/usr/bin/env bash
# Execution VERIFY: PASS when a menu_link_content titled "OG Prepopulate Eval Link" exists in the
# main menu whose URI points at /node/add/ogp_lcontent and carries og_prepopulate's SHORT query
# syntax: a single parameter whose NAME is the real OG audience field machine name on
# ogp_lcontent and whose VALUE is the live node id of the group node "OGP Link Group".
# The parent module's nested edit[...] syntax is rejected. Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $links = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title" => "OG Prepopulate Eval Link"]);
  $found = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "OGP Link Group"]);
  if (!$links || !$found) { print "FAIL fixture or link missing\n"; return; }
  $group = reset($found);
  $fields = array_keys(\Drupal::service("og.group_audience_helper")->getAllGroupAudienceFields("node", "ogp_lcontent"));
  $link = reset($links);
  $uri = $link->get("link")->uri;
  $menu = $link->getMenuName();
  $decoded = urldecode($uri);
  $parts = parse_url($decoded);
  $path_ok = isset($parts["path"]) && str_ends_with($parts["path"], "/node/add/ogp_lcontent");
  parse_str($parts["query"] ?? "", $query);
  $param_ok = FALSE;
  foreach ($fields as $field_name) {
    if (isset($query[$field_name]) && (string) $query[$field_name] === (string) $group->id()) { $param_ok = TRUE; }
  }
  $no_nested = !isset($query["edit"]);
  $ok = ($menu === "main") && $path_ok && $param_ok && $no_nested;
  print ($ok ? "PASS" : "FAIL") . " menu=" . $menu . " uri=" . $uri . " audience_fields=" . implode(",", $fields) .
    " group_nid=" . $group->id() . " path_ok=" . var_export($path_ok, TRUE) . " param_ok=" . var_export($param_ok, TRUE) .
    " no_nested=" . var_export($no_nested, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
