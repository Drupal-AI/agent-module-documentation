#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) cleanup for perimeter: restore the install-default flood
# settings (flood_threshold = 0 => ban immediately, flood_window = 3600).
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("perimeter.settings")
    ->set("flood_threshold", 0)
    ->set("flood_window", 3600)
    ->save();
  $c = \Drupal::config("perimeter.settings");
  print "cleanup: flood_threshold=".$c->get("flood_threshold")." flood_window=".$c->get("flood_window")."\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
