#!/usr/bin/env bash
# Execution VERIFY: PASS when a google_api_client OAuth account named 'gapi_oauth' exists with a
# non-empty client_id and client_secret. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("google_api_client");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("name", "gapi_oauth")->execute();
  if (!$ids) { print "FAIL no-account\n"; return; }
  $a = $storage->load(reset($ids));
  $cid = $a->getClientId();
  $sec = $a->getClientSecret();
  $ok = !empty($cid) && !empty($sec);
  print ($ok ? "PASS" : "FAIL") . " cid=" . ($cid ?: "empty") . " secret_set=" . (!empty($sec) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
