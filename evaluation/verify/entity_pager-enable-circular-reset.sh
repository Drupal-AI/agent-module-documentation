#!/usr/bin/env bash
# Execution RESET: ensure entity_pager_example View exists, is enabled, uses the entity_pager
# style, and has circular_paging FORCED OFF (so verify FAILS until the agent turns it on).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("entity_pager_example");
  if ($view) {
    $view->setStatus(TRUE);
    $d =& $view->getDisplay("default");
    $d["display_options"]["style"]["type"] = "entity_pager";
    $d["display_options"]["style"]["options"]["circular_paging"] = FALSE;
    $view->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entity_pager_example enabled, entity_pager style, circular_paging=FALSE"
