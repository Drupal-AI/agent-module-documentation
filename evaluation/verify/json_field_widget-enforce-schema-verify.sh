#!/usr/bin/env bash
# Execution VERIFY: PASS when field_jfw_valid's json_editor widget carries a syntactically
# valid JSON Schema that requires the "sku" property AND has schema_validate === TRUE.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_jfw_valid") : NULL;
  $type = $c["type"] ?? "none";
  $raw = (string) ($c["settings"]["schema"] ?? "");
  $validate = $c["settings"]["schema_validate"] ?? NULL;
  $schema = json_decode($raw, TRUE);
  $required = (array) ($schema["required"] ?? []);
  $props = array_keys((array) ($schema["properties"] ?? []));
  $ok = ($type === "json_editor")
    && is_array($schema)
    && in_array("sku", $required, TRUE)
    && in_array("sku", $props, TRUE)
    && ($validate === TRUE || $validate === 1 || $validate === "1");
  print ($ok ? "PASS" : "FAIL")
    . " widget=" . $type
    . " schema_valid_json=" . (is_array($schema) ? "yes" : "no")
    . " required=" . implode("|", $required)
    . " properties=" . implode("|", $props)
    . " schema_validate=" . var_export($validate, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
