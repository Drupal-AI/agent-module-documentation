#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) RESET for advanced_text_formatter "limit allowed HTML" task. Restores
# node.article.default's body field display to the core default text formatter (text_default),
# so the verify FAILS until the agent switches it to the `advanced_text` formatter with
# filter=limit_html and allowed_html restricted to `<a> <em> <strong>`. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("body", [
    "type" => "text_default",
    "label" => "hidden",
    "settings" => [],
    "third_party_settings" => [],
    "weight" => 1,
    "region" => "content",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.default body restored to text_default"
