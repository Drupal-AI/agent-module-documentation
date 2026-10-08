#!/usr/bin/env bash
# Introspection SETUP: configure gdpr_dump to anonymize the users_field_data.mail column with
# the email_anonymizer, so an inspecting agent can read the mapping back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gdpr_dump.table_map")
    ->set("mapping", ["users_field_data" => ["mail" => "email_anonymizer"]])
    ->set("empty_tables", [])
    ->save();
' >/dev/null 2>&1
echo "setup: gdpr_dump.table_map mapping users_field_data.mail=email_anonymizer"
