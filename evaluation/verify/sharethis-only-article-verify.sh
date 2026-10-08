#!/usr/bin/env bash
# Execution VERIFY: PASS when sharethis buttons are enabled for 'article' but NOT for 'page'
# (node_types.article truthy, node_types.page falsy/absent). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nt = \Drupal::config("sharethis.settings")->get("node_types") ?: [];
  $article_on = !empty($nt["article"]);
  $page_on = !empty($nt["page"]);
  $ok = $article_on && !$page_on;
  print ($ok ? "PASS" : "FAIL") . " article=" . var_export($nt["article"] ?? NULL, TRUE) . " page=" . var_export($nt["page"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
