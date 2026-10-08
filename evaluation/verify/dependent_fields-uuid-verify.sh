#!/usr/bin/env bash
# Execution VERIFY: PASS when field_dfu_child keeps the dependent_fields_selection handler
# (depending on field_dfu_parent) AND reference_parent_by_uuid is TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_dfu_child");
  $handler = $fc ? $fc->getSetting("handler") : "none";
  $hs = $fc ? ($fc->getSetting("handler_settings") ?? []) : [];
  $parent = $hs["dependent_fields_view"]["parent_field"] ?? "";
  $uuid = $hs["dependent_fields_view"]["reference_parent_by_uuid"] ?? NULL;
  $ok = ($fc && $handler === "dependent_fields_selection" && $parent === "field_dfu_parent" && $uuid === TRUE);
  print ($ok ? "PASS" : "FAIL") . " handler=" . $handler . " parent=" . var_export($parent, TRUE) . " uuid=" . var_export($uuid, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
