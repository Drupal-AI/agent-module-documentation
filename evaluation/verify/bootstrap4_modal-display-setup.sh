#!/usr/bin/env bash
# Introspection SETUP: create a namespaced entity browser (b4m_known) whose display plugin is
# the Bootstrap 4 Modal display, with modal_size=modal-lg, so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entity_browser\Entity\EntityBrowser;
  if (!EntityBrowser::load("b4m_known")) {
    EntityBrowser::create([
      "name" => "b4m_known", "label" => "B4M Known",
      "display" => "bootstrap4_modal",
      "display_configuration" => ["modal_size" => "modal-lg"],
      "widget_selector" => "tabs", "widget_selector_configuration" => [],
      "selection_display" => "no_display", "selection_display_configuration" => [],
      "widgets" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_browser.browser.b4m_known display=bootstrap4_modal modal_size=modal-lg"
