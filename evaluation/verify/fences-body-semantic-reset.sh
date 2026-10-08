#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) RESET for fences "semantic body markup" task. Clears any Fences third-party
# settings from node.article.default's body field so the verify FAILS until the agent
# configures fences_field_tag=article, fences_field_classes~=node-body, fences_label_tag=h2.
# Idempotent. Rebuilds caches. Exit 0.
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
