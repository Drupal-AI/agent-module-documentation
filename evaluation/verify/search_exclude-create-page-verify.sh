#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled search page 'se_task' exists, uses the
# search_exclude_node_search plugin, and excludes the se_task_type content type.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal\search\Entity\SearchPage::load("se_task");
  if (!$p) { print "FAIL page=missing\n"; return; }
  $plugin = $p->get("plugin");
  $conf = $p->get("configuration");
  $excluded = array_filter((array) ($conf["excluded_bundles"] ?? []));
  $hasType = in_array("se_task_type", array_keys($excluded), TRUE) || in_array("se_task_type", $excluded, TRUE);
  $ok = ($plugin === "search_exclude_node_search") && $hasType && $p->status();
  print ($ok ? "PASS" : "FAIL") . " plugin=" . var_export($plugin, TRUE)
    . " status=" . var_export($p->status(), TRUE)
    . " excluded=" . implode(",", array_keys($excluded)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
