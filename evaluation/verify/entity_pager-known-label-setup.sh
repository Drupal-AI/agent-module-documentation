#!/usr/bin/env bash
# Introspection SETUP: enable the shipped entity_pager_example View and set a sentinel Next
# label on its default display's Entity Pager style, so an inspecting agent can read back the
# configured Next label from live Views config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("entity_pager_example");
  if ($view) {
    $view->setStatus(TRUE);
    $d =& $view->getDisplay("default");
    $d["display_options"]["style"]["type"] = "entity_pager";
    $d["display_options"]["style"]["options"]["link_next"] = "EP_NEXT_SENTINEL_42 >";
    $view->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_pager_example default style link_next=EP_NEXT_SENTINEL_42"
