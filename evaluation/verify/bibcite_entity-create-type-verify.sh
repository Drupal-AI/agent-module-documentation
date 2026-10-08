#!/usr/bin/env bash
# Execution VERIFY: PASS when a bibcite_reference_type 'bibcite_task_type' with label
# 'Working Paper' exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\bibcite_entity\Entity\ReferenceType;
  $t = ReferenceType::load("bibcite_task_type");
  $ok = $t && ($t->label() === "Working Paper");
  print ($ok ? "PASS" : "FAIL") . " label=" . var_export($t ? $t->label() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
