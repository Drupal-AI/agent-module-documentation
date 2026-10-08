#!/usr/bin/env bash
# Introspection SETUP: ban a known documentation IP (203.0.113.77, TEST-NET-3) so an agent can
# read it back from the ban list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("ban.ip_manager");
  if (!$m->isBanned("203.0.113.77")) { $m->banIp("203.0.113.77"); }
' >/dev/null 2>&1
echo "setup: IP 203.0.113.77 is banned"
