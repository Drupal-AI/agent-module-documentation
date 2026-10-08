#!/usr/bin/env bash
# VERIFY: gl_node_build has glossify_node enabled, linking Article titles (bundles contains article, type is links/tooltips_links).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("gl_node_build");
  $g = $f ? ($f->get("filters")["glossify_node"] ?? NULL) : NULL;
  $status = $g["status"] ?? FALSE;
  $type = $g["settings"]["glossify_node_type"] ?? "";
  $bundles = $g["settings"]["glossify_node_bundles"] ?? "";
  $ok = ($status && in_array($type,["links","tooltips_links"],TRUE) && strpos((string)$bundles,"article")!==FALSE);
  print ($ok?"PASS":"FAIL")." status=".var_export($status,TRUE)." type=".$type." bundles=".$bundles."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
