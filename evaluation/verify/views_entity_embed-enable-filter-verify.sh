#!/usr/bin/env bash
# VERIFY: PASS when filter.format.vee_embed has views_embed enabled and filter_html allowed_html
# permits a <drupal-views ...> tag.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("vee_embed");
  $ve = FALSE; $tag = FALSE;
  if ($f) {
    $ve = (bool) $f->filters("views_embed")->status;
    $ah = $f->filters("filter_html")->status ? ($f->filters("filter_html")->settings["allowed_html"] ?? "") : "";
    $tag = strpos($ah, "<drupal-views") !== FALSE;
  }
  $ok = $ve && $tag;
  print ($ok ? "PASS" : "FAIL") . " views_embed=" . var_export($ve, TRUE) . " drupal-views_tag=" . var_export($tag, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
