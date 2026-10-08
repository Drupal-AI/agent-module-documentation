#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) CLEANUP for fences: remove the Fences third-party settings from
# node.article.default's body field, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd->getComponent("body");
  unset($c["third_party_settings"]["fences"]);
  $vd->setComponent("body", $c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.default body fences settings removed"
