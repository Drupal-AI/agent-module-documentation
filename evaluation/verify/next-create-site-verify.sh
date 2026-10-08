#!/usr/bin/env bash
# next execution VERIFY: PASS when next_site nextzz_task exists with base_url = https://task.example.com.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\next\Entity\NextSite;
  $s = NextSite::load("nextzz_task");
  if (!$s) { print "FAIL no-site\n"; return; }
  $b = $s->getBaseUrl();
  print (($b === "https://task.example.com") ? "PASS" : "FAIL") . " base_url=" . var_export($b, TRUE) . " preview_url=" . var_export($s->getPreviewUrl(), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
