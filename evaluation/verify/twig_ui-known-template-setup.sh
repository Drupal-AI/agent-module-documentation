#!/usr/bin/env bash
# Introspection SETUP: create one known Twig UI template config entity so an agent can read
# back its id and theme suggestion from the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("twig_template");
  if (!$s->load("twui_known")) {
    $s->create([
      "id" => "twui_known",
      "label" => "Known Sidebar Override",
      "theme_suggestion" => "region__sidebar_first",
      "template_code" => "{# twui_known #}\n<aside>{{ content }}</aside>\n",
      "themes" => ["olivero"],
      "status" => TRUE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: twig_template twui_known (theme_suggestion region__sidebar_first, olivero) created"
