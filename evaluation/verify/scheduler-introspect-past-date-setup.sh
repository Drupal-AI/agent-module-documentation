#!/usr/bin/env bash
# Introspection SETUP: enable Scheduler on Article and set a KNOWN publish_past_date behaviour
# — 'schedule' (a past publish date is re-scheduled to the next cron run rather than erroring)
# on node.type.article, so an inspecting agent (drush) can read the value back.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $type->setThirdPartySetting("scheduler", "publish_enable", TRUE);
    $type->setThirdPartySetting("scheduler", "publish_past_date", "schedule");
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: article scheduler enabled, publish_past_date=schedule"
