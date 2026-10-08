#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default allowed_extensions. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("markdownify_file_attachment.settings")
    ->set("allowed_extensions", ["txt","yml","yaml","wsdl","json"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: allowed_extensions restored to default"
