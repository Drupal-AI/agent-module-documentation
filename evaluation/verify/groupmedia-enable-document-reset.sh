#!/usr/bin/env bash
# Execution RESET: ensure group type gm_hard2 exists and has NO group_media:document relation,
# so verify FAILS until the agent installs it (tracking disabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cdel group.relationship_type.gm_hard2-group_media-document -y >/dev/null 2>&1 || true
drush php:eval '
  use Drupal\group\Entity\GroupType;
  $gt = GroupType::load("gm_hard2") ?: GroupType::create(["id" => "gm_hard2", "label" => "GM Hard2"]);
  $gt->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gm_hard2 group type present, no group_media:document relation"
