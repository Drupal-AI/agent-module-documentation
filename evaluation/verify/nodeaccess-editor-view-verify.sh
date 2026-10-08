#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article content type grants the content_editor role a default
# VIEW grant. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $g = \Drupal::config("nodeaccess.settings")->get("bundles_roles_grants");
  $v = $g["article"]["content_editor"]["grant_view"] ?? 0;
  print (((int) $v === 1) ? "PASS" : "FAIL") . " article.content_editor.grant_view=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
