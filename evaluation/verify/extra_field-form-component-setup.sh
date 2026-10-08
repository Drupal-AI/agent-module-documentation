#!/usr/bin/env bash
# Introspection SETUP: enable extra_field_example so its ExtraFieldForm plugins
# (example_markup, example_custom_submit, example_custom_input) are discoverable, and place
# extra_field_example_custom_submit on the Article default FORM display at weight 37 while
# hiding extra_field_example_markup. Also hides the example's user-form extra field so the
# shared site's user forms are untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en extra_field_example -y >/dev/null 2>&1
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("extra_field_example_custom_submit", ["weight" => 37, "region" => "content"]);
  $fd->removeComponent("extra_field_example_markup");
  $fd->save();
  $ud = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($ud) { $ud->removeComponent("extra_field_example_custom_input")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: extra_field_example enabled; node.article.default form display has extra_field_example_custom_submit at weight 37"
