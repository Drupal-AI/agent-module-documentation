#!/usr/bin/env bash
# Execution RESET: restore default allowed_extensions [txt,yml,yaml,wsdl,json] (csv NOT present)
# so verify FAILS until the agent adds csv. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("markdownify_file_attachment.settings")
    ->set("allowed_extensions", ["txt","yml","yaml","wsdl","json"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: allowed_extensions=default (no csv)"
