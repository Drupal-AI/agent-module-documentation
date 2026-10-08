#!/usr/bin/env bash
# Execution VERIFY: PASS when se_swap excludes se_swap_type, is the site's default search
# page, and core's Content search page (node_search) is disabled.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal\search\Entity\SearchPage::load("se_swap");
  if (!$p) { print "FAIL se_swap=missing\n"; return; }
  $conf = $p->get("configuration");
  $excluded = array_filter((array) ($conf["excluded_bundles"] ?? []));
  $hasType = in_array("se_swap_type", array_keys($excluded), TRUE) || in_array("se_swap_type", $excluded, TRUE);
  $default = \Drupal::config("search.settings")->get("default_page");
  $core = \Drupal\search\Entity\SearchPage::load("node_search");
  $coreOff = !$core || !$core->status();
  $ok = $hasType && ($default === "se_swap") && $coreOff && $p->status();
  print ($ok ? "PASS" : "FAIL") . " excluded=" . implode(",", array_keys($excluded))
    . " default_page=" . var_export($default, TRUE)
    . " node_search_enabled=" . var_export($core ? $core->status() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
