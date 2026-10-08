#!/usr/bin/env bash
# Execution CLEANUP: restore entity_pager_example to shipped baseline (disabled,
# circular_paging FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("entity_pager_example");
  if ($view) {
    $d =& $view->getDisplay("default");
    $d["display_options"]["style"]["options"]["circular_paging"] = FALSE;
    $view->setStatus(FALSE);
    $view->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: entity_pager_example restored (disabled, circular_paging=FALSE)"
