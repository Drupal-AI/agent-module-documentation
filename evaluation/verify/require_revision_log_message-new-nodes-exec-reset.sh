#!/usr/bin/env bash
# Execution RESET: configure Article to require a log message but with require_for_new_nodes
# FALSE, so verify FAILS until the agent enables the new-nodes requirement. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("require_revision_log_message.adminsettings")
    ->set("content_types", ["article" => "article"])
    ->set("require_for_new_nodes", FALSE)
    ->save();
' >/dev/null 2>&1
echo "reset: require_for_new_nodes = FALSE"
