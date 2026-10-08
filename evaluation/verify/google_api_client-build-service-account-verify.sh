#!/usr/bin/env bash
# Execution VERIFY: PASS when a google_api_service_client config entity gapi_task exists with the
# 'drive' service and a non-empty auth_config. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\google_api_client\Entity\GoogleApiServiceClient;
  $e = GoogleApiServiceClient::load("gapi_task");
  if (!$e) { print "FAIL no-entity\n"; return; }
  $services = $e->get("services") ?: [];
  $auth = $e->get("auth_config") ?: "";
  $ok = in_array("drive", $services, TRUE) && ($auth !== "");
  print ($ok ? "PASS" : "FAIL") . " services=" . implode(",", $services) . " auth_len=" . strlen($auth) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
