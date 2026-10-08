#!/usr/bin/env bash
# Live verification for the CVA badge component task (exercises default_variant). Two checks:
#   uses — template calls html_cva
#   out  — rendering yields the expected classes, including the defaulted rounded value
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html
FILE=web/sites/default/files/cva-eval/badge.html.twig
EXPECT='badge bg-blue rounded-full'

if [ ! -f "$FILE" ]; then echo "FAIL missing=$FILE"; exit 1; fi
uses=0; grep -q 'html_cva' "$FILE" && uses=1

out=$(drush php:eval '
  $c = file_get_contents("/var/www/html/web/sites/default/files/cva-eval/badge.html.twig");
  print trim(\Drupal::service("twig")->renderInline($c));
' 2>/dev/null | grep -vE 'Deprecated|marking parameter|^[[:space:]]*$' | tail -n1)

if [ "$uses" -eq 1 ] && [ "$out" = "$EXPECT" ]; then
  echo "PASS uses=1 out=[$out]"; exit 0
else
  echo "FAIL uses=$uses out=[$out] expected=[$EXPECT]"; exit 1
fi
