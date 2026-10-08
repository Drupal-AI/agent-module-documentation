#!/usr/bin/env bash
# Live-state verification for "add the Select translation filter in CUSTOM LIST mode with a
# priority list containing en and fr, to view st_eval_priority". Prints PASS/FAIL and exits
# 0 (pass) / 1 (fail). No arguments. Scans every display of views.view.st_eval_priority for a
# filter that is:
#   plug — plugin_id == select_translation_filter
#   list — its value (selection mode) == list
#   pri  — its priorities string contains both "en" and "fr" language codes
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $plug = FALSE; $list = FALSE; $pri = FALSE; $detail = "";
  $cfg = \Drupal::config("views.view.st_eval_priority");
  $displays = $cfg->get("display") ?: [];
  foreach ($displays as $did => $d) {
    $filters = $d["display_options"]["filters"] ?? [];
    foreach ($filters as $f) {
      if (($f["plugin_id"] ?? "") === "select_translation_filter") {
        $plug = TRUE;
        $val = $f["value"] ?? "";
        $p = strtolower($f["priorities"] ?? "");
        $detail = "display=" . $did . " value=" . $val . " priorities=" . $p;
        if ($val === "list") { $list = TRUE; }
        $codes = array_map("trim", explode(",", $p));
        if (in_array("en", $codes, TRUE) && in_array("fr", $codes, TRUE)) { $pri = TRUE; }
      }
    }
  }
  $ok = $plug && $list && $pri;
  print ($ok ? "PASS" : "FAIL") . " plug=" . ($plug?1:0) . " list=" . ($list?1:0) . " pri=" . ($pri?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
