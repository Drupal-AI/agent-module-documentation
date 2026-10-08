#!/usr/bin/env bash
# Execution VERIFY: PASS when oauth2_client config entity 'o2c_toggle' is ENABLED (status TRUE).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\oauth2_client\Entity\Oauth2Client;
  $e = Oauth2Client::load("o2c_toggle");
  if (!$e) { print "FAIL missing\n"; return; }
  $ok = ($e->status() === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($e->status(), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
