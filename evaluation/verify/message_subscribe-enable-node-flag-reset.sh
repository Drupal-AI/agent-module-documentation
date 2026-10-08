#!/usr/bin/env bash
# Execution RESET (message_subscribe): ensure the subscribe_node flag is DISABLED (its shipped
# default status), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_node")) {
    if ($f->status()) { $f->disable()->save(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: subscribe_node flag disabled"
