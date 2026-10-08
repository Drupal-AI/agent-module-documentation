#!/usr/bin/env bash
# Execution VERIFY: PASS when allow_iframed_site is configured to allow framing of /embed-ok, i.e.
# request_path.pages lists /embed-ok and negate is off. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rp = \Drupal::config("allow_iframed_site.settings")->get("request_path");
  $pages = (string) ($rp["pages"] ?? "");
  $negate = !empty($rp["negate"]);
  $hasPath = (preg_match("#(^|\n)/embed-ok(\n|$)#", $pages) === 1);
  $ok = $hasPath && !$negate;
  print ($ok ? "PASS" : "FAIL") . " negate=" . var_export($negate, TRUE) . " pages=" . str_replace("\n","\\n",var_export($pages, TRUE)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
