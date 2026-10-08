#!/usr/bin/env bash
# Execution VERIFY: PASS when a bibcite_csl_style config entity 'bibcite_harvard' with label
# 'Harvard' exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\bibcite\Entity\CslStyle;
  $s = CslStyle::load("bibcite_harvard");
  $ok = $s && ($s->label() === "Harvard");
  print ($ok ? "PASS" : "FAIL") . " label=" . var_export($s ? $s->label() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
