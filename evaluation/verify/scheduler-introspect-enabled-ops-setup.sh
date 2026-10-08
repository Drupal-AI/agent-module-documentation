#!/usr/bin/env bash
# Introspection SETUP: enable Scheduler on the Article content type with a KNOWN set of
# operations turned on — BOTH publish_enable AND unpublish_enable TRUE on node.type.article
# — so an inspecting agent (drush) can read back that scheduling is on for publish + unpublish.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $type->setThirdPartySetting("scheduler", "publish_enable", TRUE);
    $type->setThirdPartySetting("scheduler", "unpublish_enable", TRUE);
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: scheduler enabled on article (publish_enable=TRUE, unpublish_enable=TRUE)"
