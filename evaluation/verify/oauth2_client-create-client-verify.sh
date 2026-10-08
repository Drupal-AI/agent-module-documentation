#!/usr/bin/env bash
# Execution VERIFY: PASS when an oauth2_client config entity 'o2c_eval' exists, is bound to the
# authcode_example plugin, and uses credential_provider 'oauth2_client'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\oauth2_client\Entity\Oauth2Client;
  $e = Oauth2Client::load("o2c_eval");
  if (!$e) { print "FAIL missing\n"; return; }
  $plugin = $e->get("oauth2_client_plugin_id");
  $prov = $e->getCredentialProvider();
  $ok = ($plugin === "authcode_example" && $prov === "oauth2_client");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . var_export($plugin, TRUE) . " provider=" . var_export($prov, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
