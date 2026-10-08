#!/usr/bin/env bash
# Introspection SETUP: enable the extra_field_example submodule (which registers the
# ExtraFieldDisplay plugins all_nodes / article_only / formatted_field / multilingual_field)
# and place exactly ONE of them - extra_field_formatted_field - on the Article default view
# display at weight 42, hiding the others. Also hides the example's user-form extra field so
# the shared site's user forms are untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en extra_field_example -y >/dev/null 2>&1
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("extra_field_formatted_field", ["weight" => 42, "region" => "content"]);
  foreach (["extra_field_all_nodes", "extra_field_article_only", "extra_field_multilingual_field"] as $n) {
    $vd->removeComponent($n);
  }
  $vd->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) { $fd->removeComponent("extra_field_example_custom_input")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: extra_field_example enabled; node.article.default view display has extra_field_formatted_field at weight 42"
