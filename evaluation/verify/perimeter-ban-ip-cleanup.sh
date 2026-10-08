#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) cleanup for the "ban the bot IP" task: remove the test IP from
# the core Ban list so the site is left clean.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $m = \Drupal::service("ban.ip_manager");
  $m->unbanIp("203.0.113.99");
  print "cleanup: unbanned 203.0.113.99 (isBanned=".var_export($m->isBanned("203.0.113.99"), TRUE).")\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
