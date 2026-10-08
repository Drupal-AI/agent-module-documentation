#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_wishlist_type 'cw_gift' exists with allowAnonymous TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("commerce_wishlist_type")->load("cw_gift");
  $anon = $t ? (bool) $t->get("allowAnonymous") : NULL;
  $ok = ($t && $anon === TRUE);
  print (($ok) ? "PASS" : "FAIL") . " exists=" . var_export((bool)$t,TRUE) . " allowAnonymous=" . var_export($anon,TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
