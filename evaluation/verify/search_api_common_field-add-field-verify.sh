#!/usr/bin/env bash
# Execution VERIFY: PASS when index scf_task has the common_field processor enabled AND a
# field with property_path 'common_field' whose configuration.property_name is set.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api\Entity\Index;
  $index = Index::load("scf_task");
  $proc = $index ? $index->isValidProcessor("common_field") : FALSE;
  $found = "";
  if ($index) {
    foreach ($index->getFields() as $fid => $f) {
      if ($f->getPropertyPath() === "common_field") {
        $pn = $f->getConfiguration()["property_name"] ?? NULL;
        if ($pn) { $found = $fid . ":" . $pn; }
      }
    }
  }
  $ok = ($proc && $found !== "");
  print ($ok ? "PASS" : "FAIL") . " processor=" . var_export($proc, TRUE) . " field=" . ($found ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
