#!/usr/bin/env bash
# Execution VERIFY: PASS when oauth2_client config entity 'o2cex_eval' exists and uses the
# example submodule's resource_owner_example plugin. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\oauth2_client\Entity\Oauth2Client;
  $e = Oauth2Client::load("o2cex_eval");
  if (!$e) { print "FAIL missing\n"; return; }
  $p = $e->get("oauth2_client_plugin_id");
  print (($p === "resource_owner_example") ? "PASS" : "FAIL") . " plugin=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
