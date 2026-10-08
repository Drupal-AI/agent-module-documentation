#!/usr/bin/env bash
# Execution VERIFY: PASS when the Trash workflow's default moderation state is 'draft'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("workflows.workflow.workflow_buttons_trash_publishing")->get("type_settings.default_moderation_state");
  $ok = ($v === "draft");
  print ($ok ? "PASS" : "FAIL") . " default_moderation_state=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
