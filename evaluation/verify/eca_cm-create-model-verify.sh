#!/usr/bin/env bash
# Execution VERIFY: PASS when the ECA model eca_cm_task exists as an eca.eca config entity.
# (ECA 3.x does not persist a 'modeller' key in eca.eca config; the model config entity is the
# artifact eca_cm builds.) exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("eca")->load("eca_cm_task");
  $ok = (bool) $e;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($e ? "yes label=" . $e->label() : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
