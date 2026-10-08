#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for the "get the bot IP into the ban list" task.
# Ensure the test IP 203.0.113.99 is NOT banned, so verify FAILs on this baseline
# and only PASSes after the agent adds it (as perimeter would, via core Ban).
# 203.0.113.0/24 is RFC 5737 TEST-NET-3 (documentation-only, never a real host).
set -uo pipefail
cd /var/www/html

drush php:eval '
  $m = \Drupal::service("ban.ip_manager");
  $m->unbanIp("203.0.113.99");
  print "reset: 203.0.113.99 not banned (isBanned=".var_export($m->isBanned("203.0.113.99"), TRUE).")\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
