#!/usr/bin/env bash
# Execution VERIFY for "create an enabled file site_verification sv_task_file".
# PASS when sv_task_file exists, is enabled, type=file, name=site_verify_task_confirm.txt,
# content=verify-file-content-77a2c890. (Live route resolution is not checked here: Drupal's
# router rebuild uses a 'router_rebuild' lock that can be held by concurrent processes on a
# shared site, making a hard requirement on route resolution flaky through no fault of the
# agent -- the config entity state is what the agent directly controls.) Prints PASS/FAIL;
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("site_verification");
  $entity = $storage->load("sv_task_file");
  if (!$entity) {
    print "FAIL entity=missing\n";
    return;
  }
  $type = NULL;
  try {
    $type = $entity->getType()->value;
  } catch (\ValueError $e) {
    $type = "invalid";
  }
  $name = $entity->get("name");
  $content = $entity->get("content");
  $status = $entity->status();
  $ok = ($type === "file" && $name === "site_verify_task_confirm.txt" && $content === "verify-file-content-77a2c890" && $status === TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " name=" . var_export($name, TRUE) . " content=" . var_export($content, TRUE) . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
