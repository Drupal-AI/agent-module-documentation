#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for decoupled_router.
# Puts the module into a KNOWN non-default state: absolute_resolved_urls = FALSE
# (install default is TRUE). The agent must inspect the live config to report the
# current behavior. Cleanup restores the default.
# NB: set via php:eval to store a real boolean (`drush config:set ... false` is
# mis-parsed as TRUE for boolean keys on this Drush).
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("decoupled_router.settings")
    ->set("absolute_resolved_urls", FALSE)->save();
  print "setup: absolute_resolved_urls = " . var_export(\Drupal::config("decoupled_router.settings")->get("absolute_resolved_urls"), TRUE) . " (non-default)\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
