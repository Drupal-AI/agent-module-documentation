#!/usr/bin/env bash
# Execution VERIFY: PASS when url_redirect rule urlr_ext redirects /urlr-ext-src to the
# external URL https://example.com and is enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("url_redirect")->load("urlr_ext");
  $dest = $e ? $e->get("redirect_path") : "";
  $ok = $e
    && $e->get("path") === "/urlr-ext-src"
    && preg_match("`^https?://example\.com/?$`", (string) $dest)
    && (string) $e->get("status") === "1";
  print ($ok ? "PASS" : "FAIL") . " dest=" . ($dest ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
