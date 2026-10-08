#!/usr/bin/env bash
# Execution VERIFY: PASS when disqus.settings:disqus_domain === 'acmeblog'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("disqus.settings")->get("disqus_domain");
  print (($v === "acmeblog") ? "PASS" : "FAIL") . " disqus_domain=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
