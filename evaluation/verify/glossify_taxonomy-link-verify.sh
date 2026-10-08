#!/usr/bin/env bash
# VERIFY: gl_tax_link_build has glossify_taxonomy enabled as links with urlpattern /glossary/[id] from tags.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("gl_tax_link_build");
  $g = $f ? ($f->get("filters")["glossify_taxonomy"] ?? NULL) : NULL;
  $status = $g["status"] ?? FALSE;
  $type = $g["settings"]["glossify_taxonomy_type"] ?? "";
  $url = $g["settings"]["glossify_taxonomy_urlpattern"] ?? "";
  $ok = ($status && in_array($type,["links","tooltips_links"],TRUE) && $url==="/glossary/[id]");
  print ($ok?"PASS":"FAIL")." status=".var_export($status,TRUE)." type=".$type." url=".$url."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
