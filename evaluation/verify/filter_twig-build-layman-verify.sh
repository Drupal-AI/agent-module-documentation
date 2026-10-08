#!/usr/bin/env bash
# Execution VERIFY: PASS when filter.format.ft_twig_layman exists with filter_twig enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("filter.format.ft_twig_layman");
  $status = $c->get("filters.filter_twig.status");
  $exists = !$c->isNew();
  $ok = ($exists && (bool) $status === TRUE && $status !== NULL);
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export($exists, TRUE) . " filter_twig_status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
