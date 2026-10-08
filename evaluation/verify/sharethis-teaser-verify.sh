#!/usr/bin/env bash
# Execution VERIFY: PASS when location == links AND the article teaser view mode is enabled
# (sharethisnodes.article.teaser truthy). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("sharethis.settings");
  $loc = $c->get("location");
  $teaser = $c->get("sharethisnodes.article.teaser");
  $ok = ($loc === "links") && !empty($teaser);
  print ($ok ? "PASS" : "FAIL") . " location=" . var_export($loc, TRUE) . " article.teaser=" . var_export($teaser, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
