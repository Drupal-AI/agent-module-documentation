#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for the "give offenders 3 attempts before banning" task.
# Force flood_threshold back to the install default 0 (ban immediately) and
# flood_window to 3600. verify FAILs on this baseline (threshold != 3) and only
# PASSes after the agent raises the threshold to 3.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("perimeter.settings")
    ->set("flood_threshold", 0)
    ->set("flood_window", 3600)
    ->save();
  print "reset: flood_threshold=0 flood_window=3600 (ban-immediately baseline)\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
