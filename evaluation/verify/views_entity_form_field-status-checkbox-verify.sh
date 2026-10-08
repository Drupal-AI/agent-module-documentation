#!/usr/bin/env bash
# Execution VERIFY: PASS when the view veff_publish has a views_entity_form_field column for the
# node `status` (Published) field using the boolean_checkbox widget AND a fallback_view_mode of
# "teaser" for users who may not edit. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("veff_publish");
  $hit = NULL;
  if ($v) {
    foreach (array_keys($v->get("display")) as $did) {
      $fields = $v->getDisplay($did)["display_options"]["fields"] ?? [];
      foreach ($fields as $key => $f) {
        if (($f["plugin_id"] ?? "") === "entity_form_field" && ($f["field"] ?? $key) === "form_field_status") {
          $hit = $f; break 2;
        }
      }
    }
  }
  $type = $hit["plugin"]["type"] ?? NULL;
  $fb = $hit["plugin"]["fallback_view_mode"] ?? NULL;
  $ok = $hit && $type === "boolean_checkbox" && $fb === "teaser";
  print ($ok ? "PASS" : "FAIL") . " found=" . ($hit ? "yes" : "no")
    . " widget=" . var_export($type, TRUE) . " fallback_view_mode=" . var_export($fb, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
