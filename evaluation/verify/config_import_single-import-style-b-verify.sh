#!/usr/bin/env bash
# Execution VERIFY: PASS when image style cis_hard_b exists with label 'CIS Hard Bravo'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("cis_hard_b");
  $label = $s ? $s->label() : NULL;
  $ok = ($s && $label === "CIS Hard Bravo");
  print ($ok ? "PASS" : "FAIL") . " label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
