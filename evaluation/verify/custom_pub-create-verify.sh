#!/usr/bin/env bash
# Execution VERIFY: PASS when the custom_publishing_option config entity cpub_task exists AND a
# boolean node base field named cpub_task was installed by it. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\custom_pub\Entity\CustomPublishingOption;
  $entity = (bool) CustomPublishingOption::load("cpub_task");
  $defs = \Drupal::service("entity_field.manager")->getFieldStorageDefinitions("node");
  $field = isset($defs["cpub_task"]);
  $ok = $entity && $field;
  print ($ok ? "PASS" : "FAIL") . " entity=" . var_export($entity, TRUE) . " node_field=" . var_export($field, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
