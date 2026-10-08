#!/usr/bin/env bash
# Introspection SETUP: set a KNOWN per-content-type body class on the Article node type
# (third-party setting custom_body_class.classes), so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $t->setThirdPartySetting("custom_body_class", "classes", "promo-page featured");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.type.article custom_body_class.classes=promo-page featured"
