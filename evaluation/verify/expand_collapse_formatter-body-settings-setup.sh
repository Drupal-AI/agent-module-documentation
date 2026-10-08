#!/usr/bin/env bash
# Introspection SETUP: point the Article body field's default view display at the
# expand_collapse_formatter with a KNOWN set of settings, so an inspecting agent can read
# back the formatter id and its trim_length / link text from the live config. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $vd->setComponent("body", [
      "type" => "expand_collapse_formatter",
      "label" => "hidden",
      "region" => "content",
      "weight" => 1,
      "settings" => [
        "trim_length" => 250,
        "default_state" => "collapsed",
        "link_text_open" => "Read more",
        "link_text_close" => "Read less",
        "link_class_open" => "ecf-open",
        "link_class_close" => "ecf-close",
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: article body -> expand_collapse_formatter (trim_length=250, link_text_open='Read more')"
