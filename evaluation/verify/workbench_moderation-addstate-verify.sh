#!/usr/bin/env bash
# Execution VERIFY: PASS when moderation state wbm_task_state exists as an UNPUBLISHED state. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\workbench_moderation\Entity\ModerationState;
  $s = ModerationState::load("wbm_task_state");
  $pub = $s ? $s->isPublishedState() : NULL;
  $ok = ($s !== NULL && $pub === FALSE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($s ? "yes" : "no") . " published=" . var_export($pub, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
