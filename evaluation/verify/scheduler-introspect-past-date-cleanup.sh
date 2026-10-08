#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline after the publish_past_date case — reset the
# behaviour to the module default 'error' and turn Scheduler off for the Article type.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $type->setThirdPartySetting("scheduler", "publish_past_date", "error");
    $type->setThirdPartySetting("scheduler", "publish_enable", FALSE);
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: publish_past_date=error + scheduler disabled on article"
