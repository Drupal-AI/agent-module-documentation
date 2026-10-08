#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) cleanup for perimeter: remove the test IP from the core
# Ban list so the site is left clean. BanIpManager::unbanIp() takes the IP string.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $m = \Drupal::service("ban.ip_manager");
  $m->unbanIp("203.0.113.45");
  print "cleanup: unbanned 203.0.113.45 (isBanned=".var_export($m->isBanned("203.0.113.45"), TRUE).")\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
