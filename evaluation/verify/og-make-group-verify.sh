#!/usr/bin/env bash
# Execution VERIFY: PASS when node type og_task_group is registered as an OG group (og.settings
# + the three required OgRole entities exist) AND og_task_content carries an OG audience field
# targeting nodes. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\og\Og;
  $is_group = Og::isGroup("node", "og_task_group");
  $is_content = Og::isGroupContent("node", "og_task_content");
  $role_storage = \Drupal::entityTypeManager()->getStorage("og_role");
  $roles = array_keys($role_storage->loadMultiple());
  $needed = ["node-og_task_group-member", "node-og_task_group-non-member", "node-og_task_group-administrator"];
  $roles_ok = count(array_intersect($needed, $roles)) === 3;
  $fields = \Drupal::service("og.group_audience_helper")->getAllGroupAudienceFields("node", "og_task_content");
  $ok = $is_group && $is_content && $roles_ok && !empty($fields);
  print ($ok ? "PASS" : "FAIL") . " is_group=" . var_export($is_group, TRUE) . " is_group_content=" .
    var_export($is_content, TRUE) . " roles_ok=" . var_export($roles_ok, TRUE) .
    " audience_fields=" . implode(",", array_keys($fields)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
