#!/usr/bin/env bash
# Introspection SETUP: store a spec describing what the email_attachment_demo submodule does
# (it attaches its own hook source file to the core contact form mail, id 'contact_page_mail')
# so an inspecting agent can read it back from State. The demo module itself cannot be enabled
# on this site (it depends on the hidden core test module contact_test), so the fact is seeded
# in State rather than exercised live. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("email_attachment_demo_eval.spec", [
  "message_id" => "contact_page_mail",
  "attached_file" => "EmailAttachmentDemoHooks.php",
]);' >/dev/null 2>&1
echo "setup: State email_attachment_demo_eval.spec set (contact_page_mail -> EmailAttachmentDemoHooks.php)"
