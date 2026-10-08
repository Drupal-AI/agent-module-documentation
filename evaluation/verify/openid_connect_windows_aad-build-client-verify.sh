#!/usr/bin/env bash
# Live-state verification for the "create a windows_aad OpenID Connect client" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Config-level only (a real login needs a live Entra tenant): scans every
# openid_connect_client config entity and passes if one uses the windows_aad plugin with
# the required dummy settings:
#   - plugin id  = windows_aad, and the entity is enabled (status TRUE)
#   - client_id  = acme-dummy-client-id
#   - authorization_endpoint_wa AND token_endpoint_wa both contain "acme-tenant"
#   - map_ad_groups_to_roles = TRUE with a manual (method 1) mapping mentioning "administrator"
#   - userinfo_graph_api_wa = 2 (Microsoft Graph v1.0)
#   - subject_key = oid
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $pass = FALSE; $why = "no windows_aad client found";
  foreach (\Drupal::entityTypeManager()->getStorage("openid_connect_client")->loadMultiple() as $c) {
    if ($c->getPluginId() !== "windows_aad") { continue; }
    $s = $c->get("settings");
    $gm = $s["group_mapping"] ?? [];
    $checks = [
      "status"   => (bool) $c->status(),
      "client"   => (($s["client_id"] ?? "") === "acme-dummy-client-id"),
      "authz"    => (stripos($s["authorization_endpoint_wa"] ?? "", "acme-tenant") !== FALSE),
      "token"    => (stripos($s["token_endpoint_wa"] ?? "", "acme-tenant") !== FALSE),
      "maproles" => (!empty($s["map_ad_groups_to_roles"])),
      "method"   => ((int) ($gm["method"] ?? -1) === 1),
      "mapping"  => (stripos($gm["mappings"] ?? "", "administrator") !== FALSE),
      "graph"    => ((int) ($s["userinfo_graph_api_wa"] ?? -1) === 2),
      "subject"  => (($s["subject_key"] ?? "") === "oid"),
    ];
    $missing = array_keys(array_filter($checks, fn($v) => !$v));
    if (empty($missing)) { $pass = TRUE; $why = "matched by " . $c->id(); break; }
    $why = "client " . $c->id() . " missing: " . implode(",", $missing);
  }
  print ($pass ? "PASS" : "FAIL") . " " . $why . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
