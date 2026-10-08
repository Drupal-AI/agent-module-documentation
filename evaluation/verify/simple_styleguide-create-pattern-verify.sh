#!/usr/bin/env bash
# Execution VERIFY: PASS when a styleguide_pattern 'ssg_task' exists with label 'SSG Task Card'
# and pattern '<div class="ssg-task">Task</div>'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal\simple_styleguide\Entity\StyleguidePattern::load("ssg_task");
  $label = $p ? $p->label() : NULL;
  $pattern = $p ? $p->pattern : NULL;
  $ok = ($p && $label === "SSG Task Card" && strpos((string) $pattern, "ssg-task") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool)$p, TRUE) . " label=" . var_export($label,TRUE) . " pattern=" . var_export($pattern,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
