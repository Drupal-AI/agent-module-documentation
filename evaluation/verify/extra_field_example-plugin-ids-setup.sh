#!/usr/bin/env bash
# Introspection SETUP: simply enable extra_field_example so its ExtraFieldDisplay /
# ExtraFieldForm plugin definitions are registered on the live site and can be listed through
# the plugin managers. Hides the example's user-form extra field for shared-site safety.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en extra_field_example -y >/dev/null 2>&1
drush php:eval '
  $ud = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($ud) { $ud->removeComponent("extra_field_example_custom_input")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: extra_field_example enabled"
