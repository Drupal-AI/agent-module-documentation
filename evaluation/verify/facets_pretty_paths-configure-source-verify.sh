#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the "switch a facet source to pretty paths" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# Checks the facets_facet_source `eval_hard_source` now uses the facets_pretty_paths
# url processor (baseline reset leaves it on query_string).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $src = \Drupal::entityTypeManager()->getStorage("facets_facet_source")->load("eval_hard_source");
  $exists = (bool) $src;
  $proc = $exists ? (string) $src->getUrlProcessorName() : "";
  $ok = $exists && $proc === "facets_pretty_paths";
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?1:0) . " url_processor=" . $proc . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
