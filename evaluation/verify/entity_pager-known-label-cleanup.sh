#!/usr/bin/env bash
# Introspection CLEANUP: restore the entity_pager_example View to its shipped baseline
# (status disabled, link_next back to the default 'next >'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("entity_pager_example");
  if ($view) {
    $d =& $view->getDisplay("default");
    $d["display_options"]["style"]["options"]["link_next"] = "next >";
    $view->setStatus(FALSE);
    $view->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: entity_pager_example restored (disabled, link_next='next >')"
