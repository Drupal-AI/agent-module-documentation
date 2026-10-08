#!/usr/bin/env bash
# Execution VERIFY: PASS when an openid_connect client 'kc_task' exists whose plugin is
# 'keycloak' and whose settings carry keycloak_realm === 'drupal' and a non-empty
# keycloak_base. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("openid_connect_client")->load("kc_task");
  $plugin = $e ? $e->get("plugin") : "";
  $set = $e ? ($e->get("settings") ?: []) : [];
  $realm = $set["keycloak_realm"] ?? "";
  $base = $set["keycloak_base"] ?? "";
  $ok = ($e && $plugin === "keycloak" && $realm === "drupal" && $base !== "");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " realm=" . $realm . " base=" . $base . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
