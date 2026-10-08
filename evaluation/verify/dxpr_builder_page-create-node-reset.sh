#!/usr/bin/env bash
# Execution RESET: delete any nodes of type drag_and_drop_page, so verify FAILS on empty state
# until the agent creates one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityQuery("node")->condition("type", "drag_and_drop_page")->accessCheck(FALSE)->execute();
  if ($ids) {
    $storage = \Drupal::entityTypeManager()->getStorage("node");
    $storage->delete($storage->loadMultiple($ids));
  }
' >/dev/null 2>&1
echo "reset: no drag_and_drop_page nodes present"
