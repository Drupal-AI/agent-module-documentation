#!/usr/bin/env bash
# Execution VERIFY: PASS when text format tocjsf_build has the toc_js_filter enabled. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("filter.format.tocjsf_build");
  if ($c->isNew()) { print "FAIL no-format\n"; return; }
  $status = $c->get("filters.toc_js_filter.status");
  print (($status === TRUE || $status === 1 || $status === "1") ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
