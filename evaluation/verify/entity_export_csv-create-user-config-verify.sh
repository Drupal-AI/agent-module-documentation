#!/usr/bin/env bash
# Execution VERIFY: PASS when eec_user_task exports the user entity type (entity_type_id=user,
# bundle=user), delimiter ';', with the name field enabled via default_export. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("entity_export_csv")->load("eec_user_task");
  $ok = FALSE; $info = "missing";
  if ($e) {
    $et = $e->get("entity_type_id"); $b = $e->get("bundle"); $d = $e->get("delimiter");
    $t = ($e->get("fields") ?: [])["name"] ?? [];
    $enabled = !empty($t["enable"]); $exp = $t["exporter"] ?? "";
    $ok = ($et === "user" && $b === "user" && $d === ";" && $enabled && $exp === "default_export");
    $info = "entity_type=$et bundle=$b delimiter=" . var_export($d, TRUE) . " name.enable=" . var_export($enabled, TRUE) . " name.exporter=" . var_export($exp, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
