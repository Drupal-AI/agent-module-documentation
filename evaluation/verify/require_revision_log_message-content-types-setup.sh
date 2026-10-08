#!/usr/bin/env bash
# Introspection SETUP: configure require_revision_log_message so that the "blog_post"
# content type requires a revision log message, so an inspecting agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("require_revision_log_message.adminsettings")
    ->set("content_types", ["blog_post" => "blog_post"])
    ->set("require_for_new_nodes", FALSE)
    ->save();
' >/dev/null 2>&1
echo "setup: require_revision_log_message requires log on content type blog_post"
