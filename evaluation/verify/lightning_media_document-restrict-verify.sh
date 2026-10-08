#!/usr/bin/env bash
# Execution VERIFY: PASS when the Document media type's source field accepts exactly pdf and
# docx and nothing else. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "document", "field_media_document");
  $ext = $f ? preg_split("/[,\s]+/", trim((string) $f->getSetting("file_extensions"))) : [];
  $ext = array_values(array_unique(array_map("strtolower", array_filter($ext))));
  sort($ext);
  $ok = ($ext === ["docx", "pdf"]);
  print ($ok ? "PASS" : "FAIL") . " actual=" . implode(",", $ext) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
