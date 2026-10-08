#!/usr/bin/env bash
# Execution VERIFY: PASS when the Trash workflow exists with a 'trash' state and a 'delete'
# transition that moves content to trash. Read-only. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("workflows.workflow.workflow_buttons_trash_publishing");
  $id = $w->get("id");
  $has_trash = (bool) $w->get("type_settings.states.trash");
  $delete_to = $w->get("type_settings.transitions.delete.to");
  $ok = ($id === "workflow_buttons_trash_publishing") && $has_trash && ($delete_to === "trash");
  print ($ok ? "PASS" : "FAIL") . " id=" . var_export($id, TRUE) . " trash_state=" . var_export($has_trash, TRUE) . " delete_to=" . var_export($delete_to, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
