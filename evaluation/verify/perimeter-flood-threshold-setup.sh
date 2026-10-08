#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for perimeter.
# Puts the flood settings into a KNOWN non-default state: flood_threshold = 5,
# flood_window = 600 (install defaults are 0 / 3600). The agent must read the live
# perimeter.settings config and report how many suspicious requests are tolerated
# before a ban and over what window. Cleanup restores the defaults.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("perimeter.settings")
    ->set("flood_threshold", 5)
    ->set("flood_window", 600)
    ->save();
  $c = \Drupal::config("perimeter.settings");
  print "setup: flood_threshold=".$c->get("flood_threshold")." flood_window=".$c->get("flood_window")."\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
