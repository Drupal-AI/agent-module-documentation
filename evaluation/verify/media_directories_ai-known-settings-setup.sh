#!/usr/bin/env bash
# Introspection SETUP: write a known media_directories_ai.settings state (alt text on, a
# distinctive custom prompt, AI translation limited to the image bundle) so an inspecting
# agent can read it back from the live site. The matching cleanup restores the module's
# shipped config/install defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ai.settings")
    ->set("enable_ai_alt_text", TRUE)
    ->set("alt_text_prompt", "Describe this product photo for an online shop in one short sentence.")
    ->set("ai_translation_types", ["image"])
    ->set("translation_prompt", "")
    ->set("ai_fillable_fields", ["image" => ["field_media_image:alt"]])
    ->set("ai_translatable_fields", ["image" => ["name", "field_media_image:alt"]])
    ->save();
' >/dev/null 2>&1

echo "setup: media_directories_ai.settings enable_ai_alt_text=TRUE, custom alt_text_prompt, ai_translation_types=[image]"
