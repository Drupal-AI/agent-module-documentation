#!/usr/bin/env bash
# VERIFY: gl_tax_build has glossify_taxonomy enabled as tooltips from the tags vocabulary.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("gl_tax_build");
  $g = $f ? ($f->get("filters")["glossify_taxonomy"] ?? NULL) : NULL;
  $status = $g["status"] ?? FALSE;
  $type = $g["settings"]["glossify_taxonomy_type"] ?? "";
  $vocabs = $g["settings"]["glossify_taxonomy_vocabs"] ?? "";
  $ok = ($status && strpos($type,"tooltips")!==FALSE && strpos((string)$vocabs,"tags")!==FALSE);
  print ($ok?"PASS":"FAIL")." status=".var_export($status,TRUE)." type=".$type." vocabs=".$vocabs."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
