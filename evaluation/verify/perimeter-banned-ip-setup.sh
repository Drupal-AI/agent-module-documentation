#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for perimeter.
# Represents perimeter's effect by placing a known, clearly-fake test IP into the
# core Ban list via the same service perimeter uses (ban.ip_manager). The agent must
# inspect the live ban list and report which IP is currently banned. Cleanup unbans.
# 203.0.113.0/24 is the RFC 5737 TEST-NET-3 documentation range (never a real host).
set -uo pipefail
cd /var/www/html

drush php:eval '
  $m = \Drupal::service("ban.ip_manager");
  $m->banIp("203.0.113.45");
  print "setup: banned 203.0.113.45 (isBanned=".var_export($m->isBanned("203.0.113.45"), TRUE).")\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
