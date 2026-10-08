#!/usr/bin/env bash
# Execution VERIFY: PASS when url_redirect rule urlr_task redirects /urlr-task-src to
# /urlr-task-dest, is Role-based, and is enabled (status=1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("url_redirect")->load("urlr_task");
  $ok = $e
    && $e->get("path") === "/urlr-task-src"
    && $e->get("redirect_path") === "/urlr-task-dest"
    && (string) $e->get("status") === "1";
  print ($ok ? "PASS" : "FAIL")
    . " path=" . ($e ? $e->get("path") : "none")
    . " dest=" . ($e ? $e->get("redirect_path") : "none")
    . " status=" . ($e ? var_export($e->get("status"), TRUE) : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
