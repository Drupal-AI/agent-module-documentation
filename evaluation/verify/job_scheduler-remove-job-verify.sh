#!/usr/bin/env bash
# Execution VERIFY: PASS when NO job_schedule entity named 'js_remove' remains. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("job_schedule");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("name","js_remove")->execute();
  $ok = empty($ids);
  print ($ok ? "PASS" : "FAIL") . " remaining=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
