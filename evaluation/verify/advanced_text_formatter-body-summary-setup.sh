#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) SETUP for advanced_text_formatter: set node.article.default's body
# field display to the `advanced_text` formatter configured to SHOW THE SUMMARY, run token
# replacement, and NOT trim (trim_length=0, use_summary=1, token_replace=1, filter=none), so
# an inspecting agent can read these back from the entity_view_display config with drush.
# Idempotent (overwrites each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("body", [
    "type" => "advanced_text",
    "label" => "hidden",
    "settings" => [
      "trim_length" => 0,
      "ellipsis" => 1,
      "word_boundary" => 1,
      "use_summary" => 1,
      "token_replace" => 1,
      "filter" => "none",
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
echo "setup: node.article.default body -> advanced_text (use_summary=1, token_replace=1, trim_length=0, filter=none)"
