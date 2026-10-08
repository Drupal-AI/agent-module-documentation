#!/usr/bin/env bash
# Execution VERIFY: PASS when the eec_task config entity exports node/article with delimiter ','
# and the title field enabled via default_export. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("entity_export_csv")->load("eec_task");
  $ok = FALSE; $info = "missing";
  if ($e) {
    $et = $e->get("entity_type_id"); $b = $e->get("bundle"); $d = $e->get("delimiter");
    $fields = $e->get("fields") ?: [];
    $t = $fields["title"] ?? [];
    $enabled = !empty($t["enable"]); $exp = $t["exporter"] ?? "";
    $ok = ($et === "node" && $b === "article" && $d === "," && $enabled && $exp === "default_export");
    $info = "entity_type=$et bundle=$b delimiter=" . var_export($d, TRUE) . " title.enable=" . var_export($enabled, TRUE) . " title.exporter=" . var_export($exp, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
