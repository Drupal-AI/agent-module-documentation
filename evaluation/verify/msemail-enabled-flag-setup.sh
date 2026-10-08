#!/usr/bin/env bash
# Introspection SETUP (message_subscribe_email): enable exactly the email_term flag so an agent can
# read back which email_* flag is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("flag");
  $s->load("email_term")->enable()->save();
  foreach (["email_node","email_user"] as $id) { if (($f=$s->load($id)) && $f->status()) { $f->disable()->save(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: email_term flag enabled (email_node/email_user disabled)"
