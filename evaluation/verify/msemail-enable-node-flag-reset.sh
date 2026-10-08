#!/usr/bin/env bash
# Execution RESET (message_subscribe_email): ensure the email_node flag is DISABLED so verify FAILS
# until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("email_node");
  if ($f->status()) { $f->disable()->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: email_node flag disabled"
