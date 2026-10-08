#!/usr/bin/env bash
# HARD verify: PASS iff WhatsApp is enabled AND its api_url is a wa.me share link that
# carries the current-page url token. Prints PASS/FAIL, exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("social_media.settings")->get("social_media");
  $w = $m["whatsapp"] ?? [];
  $en  = (isset($w["enable"]) && $w["enable"]) ? 1 : 0;
  $url = $w["api_url"] ?? "";
  $ok_url = (stripos($url, "wa.me") !== FALSE && stripos($url, "[current-page:url]") !== FALSE) ? 1 : 0;
  print "MARK " . (($en && $ok_url) ? "PASS" : "FAIL") . " enable=$en url_ok=$ok_url MARK";
' 2>/dev/null | grep -oE 'MARK .* MARK')
out=${out#MARK }; out=${out% MARK}
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
