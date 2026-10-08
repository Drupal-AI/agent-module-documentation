#!/usr/bin/env bash
# Execution VERIFY: PASS when a view 'vrd_build' exists whose default display uses the
# views_remote_data_query query plugin AND has a Property field (plugin_id
# views_remote_data_property) with property_path 'title'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("views.view.vrd_build");
  $do = $c->get("display.default.display_options") ?: [];
  $query_ok = (($do["query"]["type"] ?? NULL) === "views_remote_data_query");
  $field_ok = FALSE;
  foreach (($do["fields"] ?? []) as $f) {
    if ((($f["plugin_id"] ?? NULL) === "views_remote_data_property") && (($f["property_path"] ?? NULL) === "title")) {
      $field_ok = TRUE; break;
    }
  }
  $exists = !$c->isNew();
  $ok = $exists && $query_ok && $field_ok;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?"y":"n") . " query=" . ($query_ok?"y":"n") . " property_field=" . ($field_ok?"y":"n") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
