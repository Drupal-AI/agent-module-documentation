#!/usr/bin/env bash
# VERIFY: gl_com_build has glossify_commerce_product enabled linking 'default' products.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("gl_com_build");
  $g = $f ? ($f->get("filters")["glossify_commerce_product"] ?? NULL) : NULL;
  $status = $g["status"] ?? FALSE;
  $type = $g["settings"]["glossify_type"] ?? "";
  $bundles = $g["settings"]["bundles"] ?? "";
  $ok = ($status && in_array($type,["links","tooltips_links","tooltips"],TRUE) && strpos((string)$bundles,"default")!==FALSE);
  print ($ok?"PASS":"FAIL")." status=".var_export($status,TRUE)." type=".$type." bundles=".$bundles."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
