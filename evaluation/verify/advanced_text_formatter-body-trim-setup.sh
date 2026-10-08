#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) SETUP for advanced_text_formatter: set node.article.default's body
# field display to the `advanced_text` formatter with a KNOWN set of settings (trim_length=200,
# ellipsis on, word_boundary on, filter=limit_html) so an inspecting agent can read them back
# from the entity_view_display config with drush. Idempotent (overwrites each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("body", [
    "type" => "advanced_text",
    "label" => "hidden",
    "settings" => [
      "trim_length" => 200,
      "ellipsis" => 1,
      "word_boundary" => 1,
      "use_summary" => 0,
      "token_replace" => 0,
      "filter" => "limit_html",
      "format" => "plain_text",
      "allowed_html" => "<a> <b> <em> <strong> <p>",
      "autop" => 0,
      "link_to_entity" => 0,
    ],
    "third_party_settings" => [],
    "weight" => 1,
    "region" => "content",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.default body -> advanced_text (trim_length=200, filter=limit_html)"
