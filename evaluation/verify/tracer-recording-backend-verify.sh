#!/usr/bin/env bash
# Execution VERIFY: PASS when Drupal\trcr_recorder\RecordingTracer implements TracerInterface AND
# actually records spans: after start()+stop(), getEvents() returns a non-empty array. exit 0/1.
set -uo pipefail
cd /var/www/html
F=web/modules/custom/trcr_recorder/src/RecordingTracer.php
if [ ! -f "$F" ]; then echo "FAIL no-file"; exit 1; fi
if ! php -l "$F" >/dev/null 2>&1; then echo "FAIL php-lint"; exit 1; fi
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/modules/custom/trcr_recorder/src/RecordingTracer.php";
  require_once $f;
  $cls = "Drupal\\trcr_recorder\\RecordingTracer";
  if (!class_exists($cls)) { print "FAIL no-class\n"; return; }
  if (!in_array("Drupal\\tracer\\TracerInterface", class_implements($cls) ?: [])) { print "FAIL not-tracer\n"; return; }
  $t = new $cls();
  $span = $t->start("eval_cat", "eval_span", ["k" => "v"]);
  $t->stop($span);
  $ev = $t->getEvents();
  $ok = (is_array($ev) && count($ev) >= 1);
  print ((($ok) ? "PASS" : "FAIL")." events=".(is_array($ev) ? count($ev) : "not-array")."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
