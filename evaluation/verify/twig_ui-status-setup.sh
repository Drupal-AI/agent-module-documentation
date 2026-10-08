#!/usr/bin/env bash
# Introspection SETUP: create two Twig UI templates, twui_on (enabled) and twui_off (disabled),
# targeting different theme suggestions, so an agent can report which one is active. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("twig_template");
  if (!$s->load("twui_on")) {
    $s->create([
      "id" => "twui_on", "label" => "Enabled block override",
      "theme_suggestion" => "block__system_branding_block",
      "template_code" => "{# twui_on #}\n", "themes" => ["olivero"], "status" => TRUE,
    ])->save();
  }
  if (!$s->load("twui_off")) {
    $s->create([
      "id" => "twui_off", "label" => "Disabled page override",
      "theme_suggestion" => "page__front",
      "template_code" => "{# twui_off #}\n", "themes" => ["olivero"], "status" => FALSE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: twui_on (status=TRUE) and twui_off (status=FALSE) created"
