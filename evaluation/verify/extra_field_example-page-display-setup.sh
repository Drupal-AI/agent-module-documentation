#!/usr/bin/env bash
# Introspection SETUP: enable extra_field_example and place its "For all nodes" pseudo-field
# (extra_field_all_nodes) on the Basic page default view display at weight 7, while removing
# it from the Article default view display. Also hides the example's user-form extra field so
# the shared site's user forms stay usable. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en extra_field_example -y >/dev/null 2>&1
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  if ($page = $s->load("node.page.default")) {
    $page->setComponent("extra_field_all_nodes", ["weight" => 7, "region" => "content"])->save();
  }
  if ($article = $s->load("node.article.default")) {
    $article->removeComponent("extra_field_all_nodes")->save();
  }
  $ud = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($ud) { $ud->removeComponent("extra_field_example_custom_input")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: extra_field_all_nodes placed on node.page.default at weight 7, removed from node.article.default"
