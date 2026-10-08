#!/usr/bin/env bash
# Introspection SETUP: create an enabled meta-tag site_verification config entity with a
# known content/token value, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_verify\Entity\SiteVerification;
  $storage = \Drupal::entityTypeManager()->getStorage("site_verification");
  if ($existing = $storage->load("sv_known_meta")) {
    $existing->delete();
  }
  SiteVerification::create([
    "id" => "sv_known_meta",
    "label" => "Known Google Verification",
    "status" => TRUE,
    "description" => "",
    "type" => "meta",
    "name" => "google-site-verification",
    "content" => "gsc-9f8e7d6c5b4a3210",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: site_verification sv_known_meta (type meta) content=gsc-9f8e7d6c5b4a3210"
