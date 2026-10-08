#!/usr/bin/env bash
# Execution VERIFY for "create an enabled Google meta-tag site_verification sv_task_meta".
# PASS when sv_task_meta exists, is enabled, type=meta, name=google-site-verification,
# content=task-token-4c8b1a2d9e. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("site_verification");
  $entity = $storage->load("sv_task_meta");
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
  $ok = ($type === "meta" && $name === "google-site-verification" && $content === "task-token-4c8b1a2d9e" && $status === TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " name=" . var_export($name, TRUE) . " content=" . var_export($content, TRUE) . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
