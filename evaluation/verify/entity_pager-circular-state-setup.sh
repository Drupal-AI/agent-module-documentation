#!/usr/bin/env bash
# Introspection SETUP: on the shipped entity_pager_example View, enable circular paging and set
# a sentinel "All" link label, so the agent must inspect live Views config to report them.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("entity_pager_example");
  if ($view) {
    $view->setStatus(TRUE);
    $d =& $view->getDisplay("default");
    $d["display_options"]["style"]["type"] = "entity_pager";
    $d["display_options"]["style"]["options"]["circular_paging"] = TRUE;
    $d["display_options"]["style"]["options"]["link_all_text"] = "EP_ALL_SENTINEL_77";
    $view->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_pager_example circular_paging=TRUE, link_all_text=EP_ALL_SENTINEL_77"
