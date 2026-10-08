#!/usr/bin/env bash
# Live verification for the CVA button component task. Two checks:
#   uses — the built template actually calls html_cva (not a hand-written class string)
#   out  — rendering the template yields exactly the expected variant + compound classes
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html
FILE=web/sites/default/files/cva-eval/button.html.twig
EXPECT='button bg-red text-lg font-bold|button bg-blue text-sm'

if [ ! -f "$FILE" ]; then echo "FAIL missing=$FILE"; exit 1; fi
uses=0; grep -q 'html_cva' "$FILE" && uses=1

out=$(drush php:eval '
  $c = file_get_contents("/var/www/html/web/sites/default/files/cva-eval/button.html.twig");
  print trim(\Drupal::service("twig")->renderInline($c));
' 2>/dev/null | grep -vE 'Deprecated|marking parameter|^[[:space:]]*$' | tail -n1)

if [ "$uses" -eq 1 ] && [ "$out" = "$EXPECT" ]; then
  echo "PASS uses=1 out=[$out]"; exit 0
else
  echo "FAIL uses=$uses out=[$out] expected=[$EXPECT]"; exit 1
fi
