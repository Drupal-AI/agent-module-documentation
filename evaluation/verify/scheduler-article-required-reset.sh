#!/usr/bin/env bash
# Reset for the "make scheduled publish dates required on Article" execution case to a clean,
# known baseline so each run is independent: on node.type.article set
# publish_required = FALSE and unpublish_required = FALSE (and enable the publish field, since
# a "required" date only makes sense when the field is on). Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $type->setThirdPartySetting("scheduler", "publish_enable", TRUE);
    $type->setThirdPartySetting("scheduler", "publish_required", FALSE);
    $type->setThirdPartySetting("scheduler", "unpublish_required", FALSE);
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: article publish_required/unpublish_required = FALSE (publish field enabled)"
