#!/usr/bin/env bash
# Live-state verification for "add the Select translation filter in ORIGINAL mode to view
# st_eval_add". Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Scans every display of the views.view.st_eval_add config entity and checks that at least
# one filter is:
#   plug — plugin_id == select_translation_filter
#   mode — its value (selection mode) == original
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $plug = FALSE; $mode = FALSE; $detail = "";
  $cfg = \Drupal::config("views.view.st_eval_add");
  $displays = $cfg->get("display") ?: [];
  foreach ($displays as $did => $d) {
    $filters = $d["display_options"]["filters"] ?? [];
    foreach ($filters as $f) {
      if (($f["plugin_id"] ?? "") === "select_translation_filter") {
        $plug = TRUE;
        $val = $f["value"] ?? "";
        $detail = "display=" . $did . " value=" . $val;
        if ($val === "original") { $mode = TRUE; }
      }
    }
  }
  $ok = $plug && $mode;
  print ($ok ? "PASS" : "FAIL") . " plug=" . ($plug?1:0) . " mode=" . ($mode?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
