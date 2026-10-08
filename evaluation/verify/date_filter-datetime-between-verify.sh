#!/usr/bin/env bash
# Execution VERIFY for "add an exposed date_filter range filter on field_df_build to the view
# date_filter_build".
# PASS when the default display of views.view.date_filter_build contains a filter with
#   plugin_id=datetime, table=node__field_df_build, field=field_df_build_value,
#   operator=between, exposed=TRUE, expose.identifier=df_build_range and top-level
#   type="datetime" (date_filter's Filter type option).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("date_filter_build");
  $found = NULL;
  if ($v) {
    $d = $v->get("display");
    foreach (($d["default"]["display_options"]["filters"] ?? []) as $f) {
      if (($f["field"] ?? "") === "field_df_build_value") { $found = $f; break; }
    }
  }
  if ($found === NULL) { print "FAIL no filter on field_df_build_value\n"; return; }
  $checks = [
    "plugin_id" => ($found["plugin_id"] ?? "") === "datetime",
    "table"     => ($found["table"] ?? "") === "node__field_df_build",
    "operator"  => ($found["operator"] ?? "") === "between",
    "exposed"   => !empty($found["exposed"]),
    "identifier"=> ($found["expose"]["identifier"] ?? "") === "df_build_range",
    "type"      => ($found["type"] ?? "") === "datetime",
  ];
  $bad = array_keys(array_filter($checks, function ($v) { return !$v; }));
  print (empty($bad) ? "PASS" : "FAIL failed=" . implode(",", $bad))
    . " plugin_id=" . ($found["plugin_id"] ?? "?")
    . " table=" . ($found["table"] ?? "?")
    . " operator=" . ($found["operator"] ?? "?")
    . " exposed=" . var_export(!empty($found["exposed"]), TRUE)
    . " identifier=" . ($found["expose"]["identifier"] ?? "?")
    . " type=" . ($found["type"] ?? "unset") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
