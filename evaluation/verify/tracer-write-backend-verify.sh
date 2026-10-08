#!/usr/bin/env bash
# Execution VERIFY: PASS when web/modules/custom/trcr_backend/src/SpanTracer.php defines
# Drupal\trcr_backend\SpanTracer implementing Drupal\tracer\TracerInterface. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
F=web/modules/custom/trcr_backend/src/SpanTracer.php
if [ ! -f "$F" ]; then echo "FAIL no-file"; exit 1; fi
if ! php -l "$F" >/dev/null 2>&1; then echo "FAIL php-lint"; exit 1; fi
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/modules/custom/trcr_backend/src/SpanTracer.php";
  require_once $f;
  $cls = "Drupal\\trcr_backend\\SpanTracer";
  if (!class_exists($cls)) { print "FAIL no-class\n"; return; }
  $ok = in_array("Drupal\\tracer\\TracerInterface", class_implements($cls) ?: []);
  print ((($ok) ? "PASS" : "FAIL")." class=".$cls."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
