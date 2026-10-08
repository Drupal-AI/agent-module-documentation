#!/usr/bin/env bash
# Execution RESET: ensure group type gm_hard exists and has NO group_media:image relation, so
# verify FAILS until the agent installs it with tracking on. Config-level delete. Idempotent.
set -uo pipefail
cd /var/www/html
drush cdel group.relationship_type.gm_hard-group_media-image -y >/dev/null 2>&1 || true
drush php:eval '
  use Drupal\group\Entity\GroupType;
  $gt = GroupType::load("gm_hard") ?: GroupType::create(["id" => "gm_hard", "label" => "GM Hard"]);
  $gt->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gm_hard group type present, no group_media:image relation"
