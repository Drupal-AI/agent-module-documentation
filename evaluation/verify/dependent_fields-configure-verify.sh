#!/usr/bin/env bash
# Execution VERIFY: PASS when field_dft_child uses the dependent_fields_selection handler and
# its dependent_fields_view.parent_field is field_dft_parent. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_dft_child");
  $handler = $fc ? $fc->getSetting("handler") : "none";
  $hs = $fc ? ($fc->getSetting("handler_settings") ?? []) : [];
  $parent = $hs["dependent_fields_view"]["parent_field"] ?? "";
  $ok = ($fc && $handler === "dependent_fields_selection" && $parent === "field_dft_parent");
  print ($ok ? "PASS" : "FAIL") . " handler=" . $handler . " parent_field=" . var_export($parent, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
