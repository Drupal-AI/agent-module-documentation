#!/usr/bin/env bash
# Introspection SETUP: store a known email-attachment spec in State so an inspecting agent can
# read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("email_attachment_eval.spec", [
    "filename" => "quarterly-report.pdf",
    "filemime" => "application/pdf",
  ]);
' >/dev/null 2>&1
echo "setup: State email_attachment_eval.spec set (quarterly-report.pdf)"
