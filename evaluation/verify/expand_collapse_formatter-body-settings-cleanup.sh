#!/usr/bin/env bash
# Introspection CLEANUP: restore the Article body field's default view display to its core
# baseline (text_default formatter, label hidden, weight 1, content region), undoing the
# setup that switched it to expand_collapse_formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $vd->setComponent("body", [
      "type" => "text_default",
      "label" => "hidden",
      "region" => "content",
      "weight" => 1,
      "settings" => [],
      "third_party_settings" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: article body restored to text_default formatter"
