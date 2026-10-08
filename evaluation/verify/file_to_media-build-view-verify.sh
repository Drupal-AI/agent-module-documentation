#!/usr/bin/env bash
# Execution VERIFY: PASS when view ftm_files exists, its base_table is file_managed, and some
# display has a field handler with plugin_id 'file_to_media'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("ftm_files");
  $found = FALSE; $base = NULL;
  if ($v) {
    $base = $v->get("base_table");
    foreach ($v->get("display") as $display) {
      foreach ($display["display_options"]["fields"] ?? [] as $f) {
        if (($f["plugin_id"] ?? NULL) === "file_to_media") { $found = TRUE; }
      }
    }
  }
  $ok = ($v && $base === "file_managed" && $found);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($v ? "yes" : "no") . " base=" . var_export($base, TRUE) . " field=" . ($found ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
