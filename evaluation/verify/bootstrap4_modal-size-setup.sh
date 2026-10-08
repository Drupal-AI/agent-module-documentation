#!/usr/bin/env bash
# Introspection SETUP: create entity browser b4m_size using the Bootstrap 4 Modal display with
# modal_size=modal-sm, so an agent can read back the configured modal size.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entity_browser\Entity\EntityBrowser;
  if (!EntityBrowser::load("b4m_size")) {
    EntityBrowser::create([
      "name" => "b4m_size", "label" => "B4M Size",
      "display" => "bootstrap4_modal", "display_configuration" => ["modal_size" => "modal-sm"],
      "widget_selector" => "tabs", "widget_selector_configuration" => [],
      "selection_display" => "no_display", "selection_display_configuration" => [], "widgets" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_browser.browser.b4m_size modal_size=modal-sm"
