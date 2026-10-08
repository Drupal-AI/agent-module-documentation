#!/usr/bin/env bash
# HARD verify: the after-login redirect must be DISABLED, i.e.
# moderation_dashboard.settings:redirect_on_login === false (boolean).
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html

val=$(drush php:eval '
  $v = \Drupal::config("moderation_dashboard.settings")->get("redirect_on_login");
  print "MDREDIR:" . (($v === FALSE) ? "off" : "on");
' 2>/dev/null | grep -oE 'MDREDIR:(off|on)')

if [ "$val" = "MDREDIR:off" ]; then
  echo "PASS redirect_on_login is disabled (false)"
  exit 0
else
  echo "FAIL redirect_on_login is not disabled ($val)"
  exit 1
fi
