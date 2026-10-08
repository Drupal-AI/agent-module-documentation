#!/usr/bin/env bash
# Execution VERIFY: PASS when facets_bot_blocker_limit === 2 and facet_bot_blocker_return_gone === true.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("facet_bot_blocker.settings");
  $limit = $c->get("facets_bot_blocker_limit");
  $gone = $c->get("facet_bot_blocker_return_gone");
  $ok = ((int) $limit === 2 && (bool) $gone === TRUE && $gone !== NULL);
  print ($ok ? "PASS" : "FAIL") . " limit=" . var_export($limit, TRUE) . " return_gone=" . var_export($gone, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
