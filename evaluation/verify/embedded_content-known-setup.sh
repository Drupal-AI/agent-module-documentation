#!/usr/bin/env bash
# Introspection SETUP: create an embedded_content_button config entity 'ec_known' with a known
# modal_title and label_singular so an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\embedded_content\Entity\EmbeddedContentButton;
  if ($e = EmbeddedContentButton::load("ec_known")) { $e->delete(); }
  EmbeddedContentButton::create(["id"=>"ec_known","label"=>"EC Known","settings"=>["label_singular"=>"gadget","modal_title"=>"EC Known Modal","submit_button_text"=>"Insert","icon"=>"<svg></svg>","condition"=>"","dialog_settings"=>["width"=>"800px","height"=>"auto"]]])->save();
' >/dev/null 2>&1
echo "setup: embedded_content.button.ec_known (modal_title='EC Known Modal', label_singular='gadget')"
