#!/usr/bin/env bash
# Execution VERIFY: PASS when the ckabbr_title format's filter_html allowed_html permits the
# title attribute on <abbr> (i.e. the abbr entry declares 'title'). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("ckabbr_title");
  $allowed = "";
  if ($f) {
    $cfg = $f->filters("filter_html")->getConfiguration();
    $allowed = $cfg["settings"]["allowed_html"] ?? "";
  }
  // Match an <abbr ...> entry that includes the title attribute (allowing extra attrs/order).
  $ok = (bool) preg_match("/<abbr\b[^>]*\btitle\b[^>]*>/i", $allowed);
  print ($ok ? "PASS" : "FAIL") . " allowed_html=" . json_encode($allowed) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
