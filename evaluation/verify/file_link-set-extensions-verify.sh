#!/usr/bin/env bash
# Execution VERIFY: PASS when field_flink_cfg (file_link) allows the pdf extension in its
# file_extensions setting. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_flink_cfg");
  $ext = $fc ? (string) $fc->getSetting("file_extensions") : "";
  $ok = ($fc && in_array("pdf", preg_split("/[\s,]+/", strtolower(trim($ext))), TRUE));
  print ($ok ? "PASS" : "FAIL") . " file_extensions=" . var_export($ext, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
