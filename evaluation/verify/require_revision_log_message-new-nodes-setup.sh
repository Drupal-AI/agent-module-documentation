#!/usr/bin/env bash
# Introspection SETUP: configure require_revision_log_message to require a log message on
# Article AND to enforce it for NEW nodes (require_for_new_nodes = TRUE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("require_revision_log_message.adminsettings")
    ->set("content_types", ["article" => "article"])
    ->set("require_for_new_nodes", TRUE)
    ->save();
' >/dev/null 2>&1
echo "setup: require_for_new_nodes = TRUE (article configured)"
