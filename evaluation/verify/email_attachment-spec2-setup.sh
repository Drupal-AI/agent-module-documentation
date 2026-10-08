#!/usr/bin/env bash
# Introspection SETUP: store a multi-attachment spec in State.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("email_attachment_eval.spec2", ["attachments"=>[["filename"=>"summary.csv"],["filename"=>"details.csv"]]]);' >/dev/null 2>&1
echo "setup: State email_attachment_eval.spec2 set (summary.csv, details.csv)"
