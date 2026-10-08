#!/usr/bin/env bash
# Introspection SETUP: write a known field-to-pattern-setting mapping into the module's
# ui_patterns_settings.settings config so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ui_patterns_settings.settings")
    ->set("mapping", [
      "node--field_promo" => "card::title",
      "node--field_style" => "card::variant",
    ])->save();
' >/dev/null 2>&1
echo "setup: ui_patterns_settings.settings mapping = {node--field_promo: card::title, node--field_style: card::variant}"
