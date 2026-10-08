#!/usr/bin/env bash
# Execution VERIFY: PASS when state twig_real_content_out1 equals the twig_real_content
# real_content FILTER applied to the input string (computed live). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $in = \Drupal::state()->get("twig_real_content_in1");
  $ext = new \Drupal\twig_real_content\TwigRealContentTwigExtension();
  $cb = $ext->getFilters()[0]->getCallable();
  $expected = $cb($in);
  $got = \Drupal::state()->get("twig_real_content_out1");
  $ok = ($got === $expected);
  print ($ok ? "PASS" : "FAIL") . " expected=" . var_export($expected, TRUE) . " got=" . var_export($got, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
