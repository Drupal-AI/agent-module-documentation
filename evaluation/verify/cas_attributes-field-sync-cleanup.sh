#!/usr/bin/env bash
# Execution CLEANUP: restore the CAS Attributes token + field-mapping configuration to its
# install defaults after the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cas_attributes.settings")
    ->set("sitewide_token_support", FALSE)
    ->set("token_allowed_attributes", [])
    ->set("field.sync_frequency", 0)
    ->set("field.overwrite", FALSE)
    ->set("field.mappings", [])
    ->save();
' >/dev/null 2>&1
echo "cleanup: cas_attributes.settings token + field mapping configuration restored to defaults"
