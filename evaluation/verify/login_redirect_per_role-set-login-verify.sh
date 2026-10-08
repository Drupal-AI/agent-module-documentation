#!/usr/bin/env bash
# Execution VERIFY: PASS when the content_editor LOGIN redirect URL is exactly /admin/content
# in login_redirect_per_role.settings. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("login_redirect_per_role.settings");
  $url = $c->get("login.content_editor.redirect_url");
  $ok = ($url === "/admin/content");
  print ($ok ? "PASS" : "FAIL") . " login.content_editor.redirect_url=" . var_export($url, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
