#!/usr/bin/env bash
# Live verification for the twig_vardumper "dump an array with vardumper()" task. Checks:
#   uses — the built template calls the module's vardumper( function specifically
#   out  — rendering it with Twig debug ON yields Symfony VarDumper markup (sf-dump)
#          containing BOTH known array values TVD-ALPHA and TVD-BETA
# Twig debug is toggled in-process only (enableDebug); no global state is mutated.
# Prints PASS/FAIL, exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html
FILE=web/sites/default/files/twig_vardumper-eval/vardumper.html.twig

if [ ! -f "$FILE" ]; then echo "FAIL missing=$FILE"; exit 1; fi
uses=0; grep -q 'vardumper(' "$FILE" && uses=1

res=$(drush php:eval '
  $t = \Drupal::service("twig");
  $t->enableDebug();
  $c = file_get_contents("/var/www/html/web/sites/default/files/twig_vardumper-eval/vardumper.html.twig");
  $out = $t->renderInline($c);
  $a  = strpos($out, "TVD-ALPHA") !== false ? 1 : 0;
  $b  = strpos($out, "TVD-BETA")  !== false ? 1 : 0;
  $sf = strpos($out, "sf-dump")   !== false ? 1 : 0;
  print "a=$a b=$b sf=$sf";
' 2>/dev/null | grep -oE 'a=[01] b=[01] sf=[01]' | tail -n1)

a=$(echo "$res"  | sed -E 's/.*a=([01]).*/\1/')
b=$(echo "$res"  | sed -E 's/.* b=([01]).*/\1/')
sf=$(echo "$res" | sed -E 's/.*sf=([01]).*/\1/')

if [ "$uses" = "1" ] && [ "$a" = "1" ] && [ "$b" = "1" ] && [ "$sf" = "1" ]; then
  echo "PASS uses=1 a=1 b=1 sf=1"; exit 0
else
  echo "FAIL uses=$uses a=${a:-0} b=${b:-0} sf=${sf:-0} (want vardumper() output to contain TVD-ALPHA and TVD-BETA as VarDumper markup)"; exit 1
fi
