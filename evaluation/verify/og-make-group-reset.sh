#!/usr/bin/env bash
# Execution RESET: create the node types og_task_group and og_task_content but make sure
# NEITHER is wired into Organic Groups - the group registration is removed and any og_audience
# field on og_task_content is deleted - so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\og\Og;
  foreach (["og_task_group" => "OG Task Group", "og_task_content" => "OG Task Content"] as $id => $label) {
    if (!NodeType::load($id)) { NodeType::create(["type" => $id, "name" => $label])->save(); }
  }
  if (Og::isGroup("node", "og_task_group")) { Og::groupTypeManager()->removeGroup("node", "og_task_group"); }
  foreach (\Drupal::service("og.group_audience_helper")->getAllGroupAudienceFields("node", "og_task_content") as $name => $definition) {
    if ($fc = FieldConfig::loadByName("node", "og_task_content", $name)) { $fc->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node types og_task_group / og_task_content exist but are not OG group or group content"
