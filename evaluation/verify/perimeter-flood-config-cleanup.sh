#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) cleanup for the "3 attempts before ban" task: restore the
# install-default flood settings (threshold 0, window 3600).
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("perimeter.settings")
    ->set("flood_threshold", 0)
    ->set("flood_window", 3600)
    ->save();
  print "cleanup: flood_threshold=0 flood_window=3600\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
