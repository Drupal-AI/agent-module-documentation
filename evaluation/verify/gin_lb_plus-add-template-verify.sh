#!/usr/bin/env bash
# Execution VERIFY (gin_lb_plus): PASS when at least one section_library_template entity with
# label 'glb_plus_exec' exists on the live site - the entity type gin_lb_plus's "Library" tab
# and its "Add to library" button operate on. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("section_library_template");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label", "glb_plus_exec")->execute();
  $ok = \count($ids) > 0;
  print ($ok ? "PASS" : "FAIL") . " glb_plus_exec_count=" . \count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
