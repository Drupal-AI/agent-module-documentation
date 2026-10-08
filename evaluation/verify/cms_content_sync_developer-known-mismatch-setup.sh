#!/usr/bin/env bash
# Introspection SETUP: flag flow ccs_known_flow in cms_content_sync.developer:version_mismatch.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cms_content_sync.developer")
    ->set("version_mismatch", ["ccs_known_flow" => ["name" => "CCS Known Flow"]])->save();
' >/dev/null 2>&1
echo "setup: cms_content_sync.developer version_mismatch flags ccs_known_flow"
