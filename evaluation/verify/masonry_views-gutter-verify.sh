#!/usr/bin/env bash
# Execution VERIFY: PASS when masonry_views_gutter's masonry style has gutterWidth == 20.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("masonry_views_gutter");
  $s = $v ? ($v->getDisplay("default")["display_options"]["style"] ?? []) : [];
  $type = $s["type"] ?? "none";
  $g = $s["options"]["gutterWidth"] ?? NULL;
  $ok = ($type === "masonry") && ((string) $g === "20");
  print ($ok ? "PASS" : "FAIL") . " style=" . $type . " gutterWidth=" . var_export($g, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
