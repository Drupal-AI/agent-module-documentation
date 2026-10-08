#!/usr/bin/env bash
# Execution RESET: make sure extra_field_example IS enabled but its example_markup form
# pseudo-field is explicitly hidden on the Article default form display (hidden: true also
# prevents visible=true from re-adding it), so verify FAILS until the agent places it at
# weight 25. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en extra_field_example -y >/dev/null 2>&1
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) { $fd->removeComponent("extra_field_example_markup")->save(); }
  $ud = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($ud) { $ud->removeComponent("extra_field_example_custom_input")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: extra_field_example enabled, extra_field_example_markup hidden on node.article.default form display"
