#!/usr/bin/env bash
# Introspection SETUP: create two file-type site_verification entities, sv_file_on (enabled)
# and sv_file_off (disabled), so an inspecting agent must determine which is actually served.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_verify\Entity\SiteVerification;
  $storage = \Drupal::entityTypeManager()->getStorage("site_verification");
  foreach (["sv_file_on", "sv_file_off"] as $id) {
    if ($existing = $storage->load($id)) {
      $existing->delete();
    }
  }
  SiteVerification::create([
    "id" => "sv_file_on",
    "label" => "Enabled File Verification",
    "status" => TRUE,
    "description" => "",
    "type" => "file",
    "name" => "BingSiteAuth-onsite.xml",
    "content" => "<?xml version=\"1.0\"?><users><user>onsite</user></users>",
  ])->save();
  SiteVerification::create([
    "id" => "sv_file_off",
    "label" => "Disabled File Verification",
    "status" => FALSE,
    "description" => "",
    "type" => "file",
    "name" => "BingSiteAuth-offsite.xml",
    "content" => "<?xml version=\"1.0\"?><users><user>offsite</user></users>",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sv_file_on (enabled) and sv_file_off (disabled) file verifications created"
