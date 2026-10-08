#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article content type's default 'author' grant has grant_update
# enabled (edit). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $g = \Drupal::config("nodeaccess.settings")->get("bundles_roles_grants");
  $v = $g["article"]["author"]["grant_update"] ?? 0;
  print (((int) $v === 1) ? "PASS" : "FAIL") . " article.author.grant_update=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
