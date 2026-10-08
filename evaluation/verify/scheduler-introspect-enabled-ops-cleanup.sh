#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline after the "which operations are enabled" case —
# turn Scheduler off for the Article content type (publish_enable/unpublish_enable = FALSE).
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $type->setThirdPartySetting("scheduler", "publish_enable", FALSE);
    $type->setThirdPartySetting("scheduler", "unpublish_enable", FALSE);
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: scheduler disabled on article (publish_enable/unpublish_enable = FALSE)"
