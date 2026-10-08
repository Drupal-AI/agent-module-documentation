#!/usr/bin/env bash
# Introspection SETUP (demo): store a fixture describing what the demo attaches, so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("email_attachment_demo_eval.target", [
    "mail_id" => "contact_page_mail",
    "attaches" => "email_attachment_demo.module",
  ]);
' >/dev/null 2>&1
echo "setup: State email_attachment_demo_eval.target set (contact_page_mail)"
