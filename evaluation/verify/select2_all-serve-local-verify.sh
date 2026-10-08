#!/usr/bin/env bash
# Execution VERIFY: PASS when the resolved select2_all 'select2' library serves its JS from a
# local /libraries/select2/dist path (i.e. select2_all_library_info_alter() found the local
# copy) rather than the external CDN. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $lib = \Drupal::service("library.discovery")->getLibraryByName("select2_all", "select2");
  $js = $lib["js"][0]["data"] ?? "";
  $ok = is_string($js) && str_starts_with($js, "/libraries/select2/dist");
  print ($ok ? "PASS" : "FAIL") . " js=" . $js . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
