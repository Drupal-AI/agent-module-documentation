#!/usr/bin/env bash
# Execution VERIFY: PASS when view ftm_target_view exists and some display now has a field
# handler with plugin_id 'file_to_media'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("ftm_target_view");
  $found = FALSE;
  if ($v) {
    foreach ($v->get("display") as $display) {
      foreach ($display["display_options"]["fields"] ?? [] as $f) {
        if (($f["plugin_id"] ?? NULL) === "file_to_media") { $found = TRUE; }
      }
    }
  }
  $ok = ($v && $found);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($v ? "yes" : "no") . " file_to_media_field=" . ($found ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
