#!/usr/bin/env bash
# Introspection SETUP: create a known riddle config entity so an agent can read its solution back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("riddle");
  if (!$s->load("ri_known")) {
    $s->create(["id"=>"ri_known","question"=>"What colour is the sky on a clear day?","solution"=>"blue,Blue","hint"=>"Look up.","status"=>TRUE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: riddle ri_known created (solution=blue,Blue)"
