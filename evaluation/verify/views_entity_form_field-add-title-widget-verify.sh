#!/usr/bin/env bash
# Execution VERIFY: PASS when the view veff_task has a views_entity_form_field column for the
# node `title` field: a field whose plugin_id is entity_form_field, field/id form_field_title,
# on the node_field_data table, using the string_textfield widget. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("veff_task");
  $hit = NULL;
  if ($v) {
    foreach (array_keys($v->get("display")) as $did) {
      $fields = $v->getDisplay($did)["display_options"]["fields"] ?? [];
      foreach ($fields as $key => $f) {
        if (($f["plugin_id"] ?? "") === "entity_form_field" && ($f["field"] ?? $key) === "form_field_title") {
          $hit = $f; break 2;
        }
      }
    }
  }
  $type = $hit["plugin"]["type"] ?? NULL;
  $table = $hit["table"] ?? NULL;
  $ok = $hit && $type === "string_textfield" && $table === "node_field_data";
  print ($ok ? "PASS" : "FAIL") . " found=" . ($hit ? "yes" : "no")
    . " table=" . var_export($table, TRUE) . " widget=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
