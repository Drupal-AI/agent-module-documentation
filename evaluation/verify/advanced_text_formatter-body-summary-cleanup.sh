#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) CLEANUP for advanced_text_formatter: restore node.article.default's
# body field display to the core default text formatter (text_default), the site baseline.
# Idempotent. Exit 0.
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
echo "cleanup: node.article.default body restored to text_default"
