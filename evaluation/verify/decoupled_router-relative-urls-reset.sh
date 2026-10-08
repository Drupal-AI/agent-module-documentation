#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for decoupled_router: restore the install default
# absolute_resolved_urls = TRUE, so on empty state the resolver returns ABSOLUTE
# URLs and verify FAILs until the agent switches the setting to relative.
# Uses php:eval to store a real boolean.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("decoupled_router.settings")
    ->set("absolute_resolved_urls", TRUE)->save();
  print "reset: absolute_resolved_urls = " . var_export(\Drupal::config("decoupled_router.settings")->get("absolute_resolved_urls"), TRUE) . " (default)\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
