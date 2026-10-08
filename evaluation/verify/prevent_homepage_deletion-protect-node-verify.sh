#!/usr/bin/env bash
# Execution VERIFY: PASS when 'PHD Task Page' is really protected and 'PHD Control Page' is not.
# Checks live node access: phd_task_user holds "delete any article content" but NOT
# delete_homepage_node, so they must be DENIED delete on the task node and still ALLOWED delete
# on the control node. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $task = $storage->loadByProperties(["title" => "PHD Task Page"]);
  $control = $storage->loadByProperties(["title" => "PHD Control Page"]);
  $user = user_load_by_name("phd_task_user");
  if (!$task || !$control || !$user) { print "FAIL fixture missing\n"; return; }
  $task = reset($task);
  $control = reset($control);
  \Drupal::entityTypeManager()->getAccessControlHandler("node")->resetCache();
  $task_delete = $task->access("delete", $user);
  $control_delete = $control->access("delete", $user);
  $ok = (!$task_delete) && $control_delete;
  print ($ok ? "PASS" : "FAIL") . " task_delete=" . var_export($task_delete, TRUE) .
    " control_delete=" . var_export($control_delete, TRUE) .
    " protected_urls=" . json_encode(\Drupal::config("prevent_homepage_deletion.settings")->get("protected_urls")) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
