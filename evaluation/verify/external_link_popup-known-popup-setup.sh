#!/usr/bin/env bash
# Introspection SETUP: create an external_link_popup config entity elp_known targeting the
# domain example.com with a known title, so an inspecting agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\external_link_popup\Entity\ExternalLinkPopup;
  if (!ExternalLinkPopup::load("elp_known")) {
    ExternalLinkPopup::create([
      "id" => "elp_known", "name" => "Known Popup", "status" => TRUE, "weight" => 0,
      "close" => TRUE, "title" => "Leaving For Example",
      "body" => ["value" => "Continue to example.com?", "format" => "plain_text"],
      "labelyes" => "Continue", "labelno" => "Stay", "domains" => "example.com", "new_tab" => FALSE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: external_link_popup elp_known targets example.com, title 'Leaving For Example'"
