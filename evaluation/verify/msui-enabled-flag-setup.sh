#!/usr/bin/env bash
# Introspection SETUP (message_subscribe_ui): enable exactly the subscribe_user subscription flag so
# an agent can read back which subscription flag is enabled (drives a Subscriptions sub-tab).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("flag");
  $s->load("subscribe_user")->enable()->save();
  foreach (["subscribe_node","subscribe_term"] as $id) { if (($f=$s->load($id)) && $f->status()) { $f->disable()->save(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: subscribe_user flag enabled (subscribe_node/subscribe_term disabled)"
