#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) RESET for fences "inline body markup" task. Clears any Fences third-party
# settings from node.article.default's body field so verify FAILS until the agent sets
# fences_field_tag=span, fences_label_tag=none, fences_field_item_tag=none. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd->getComponent("body");
  unset($c["third_party_settings"]["fences"]);
  $vd->setComponent("body", $c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.default body fences settings cleared"
