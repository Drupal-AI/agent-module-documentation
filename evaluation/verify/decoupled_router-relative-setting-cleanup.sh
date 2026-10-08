#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) cleanup for decoupled_router: restore the install default
# absolute_resolved_urls = TRUE. Uses php:eval to store a real boolean.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("decoupled_router.settings")
    ->set("absolute_resolved_urls", TRUE)->save();
  print "cleanup: absolute_resolved_urls restored to " . var_export(\Drupal::config("decoupled_router.settings")->get("absolute_resolved_urls"), TRUE) . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
