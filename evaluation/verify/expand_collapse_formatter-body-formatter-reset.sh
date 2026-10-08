#!/usr/bin/env bash
# Execution RESET for "configure the Article body to the expand_collapse_formatter". Forces a
# clean, known-WRONG baseline so verify FAILS until the agent does the work: the Article body
# default view display is restored to core's text_default formatter (label hidden, weight 1,
# content region). Idempotent. Rebuilds caches. Exit 0.
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
echo "reset: article body -> text_default (agent must switch it to expand_collapse_formatter)"
