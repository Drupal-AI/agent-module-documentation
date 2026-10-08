#!/usr/bin/env bash
# Execution VERIFY: PASS when field_glb_img on Article's default view display uses a glightbox formatter
# (glightbox or glightbox_responsive). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_glb_img") : NULL;
  $type = $c["type"] ?? "none";
  $ok = in_array($type, ["glightbox","glightbox_responsive"], TRUE);
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type;
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
