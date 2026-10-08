#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled Optimizely project exists with code 777000 whose paths
# target /campaign (substring match). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("optimizely");
  $match = NULL;
  foreach ($s->loadMultiple() as $p) {
    if ((int) $p->getCode() === 777000 && $p->getState() && strpos((string) $p->getPaths(), "/campaign") !== FALSE) { $match = $p->id(); break; }
  }
  print ($match ? "PASS id=".$match : "FAIL no enabled project with code 777000 targeting /campaign") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
