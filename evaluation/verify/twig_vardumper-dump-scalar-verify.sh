#!/usr/bin/env bash
# Live verification for the twig_vardumper "dump a scalar" task. Checks:
#   uses — the built template actually calls dump( (not a hand-written literal)
#   out  — rendering it with Twig debug ON yields Symfony VarDumper markup (sf-dump)
#          containing the exact dumped value TVD-SCALAR-9021
# The twig service's debug flag is toggled in-process only (enableDebug), so no global
# twig.config / cache state is mutated. Prints PASS/FAIL, exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html
FILE=web/sites/default/files/twig_vardumper-eval/dump.html.twig
VAL='TVD-SCALAR-9021'

if [ ! -f "$FILE" ]; then echo "FAIL missing=$FILE"; exit 1; fi
uses=0; grep -q 'dump(' "$FILE" && uses=1

res=$(drush php:eval '
  $t = \Drupal::service("twig");
  $t->enableDebug();
  $c = file_get_contents("/var/www/html/web/sites/default/files/twig_vardumper-eval/dump.html.twig");
  $out = $t->renderInline($c);
  $val = strpos($out, "TVD-SCALAR-9021") !== false ? 1 : 0;
  $sf  = strpos($out, "sf-dump") !== false ? 1 : 0;
  print "val=$val sf=$sf";
' 2>/dev/null | grep -oE 'val=[01] sf=[01]' | tail -n1)

val=$(echo "$res" | sed -E 's/.*val=([01]).*/\1/')
sf=$(echo "$res" | sed -E 's/.*sf=([01]).*/\1/')

if [ "$uses" = "1" ] && [ "$val" = "1" ] && [ "$sf" = "1" ]; then
  echo "PASS uses=1 val=1 sf=1"; exit 0
else
  echo "FAIL uses=$uses val=${val:-0} sf=${sf:-0} (want the dump() output to contain $VAL as VarDumper markup)"; exit 1
fi
