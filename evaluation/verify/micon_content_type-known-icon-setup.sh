#!/usr/bin/env bash
# Introspection SETUP: create content type micon_ct_med with a Micon icon (fa-flag) stored as a
# micon_content_type third-party setting, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("micon_ct_med") ?: NodeType::create(["type"=>"micon_ct_med","name"=>"Micon CT Med"]);
  $t->setThirdPartySetting("micon_content_type","icon","fa-flag");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.type micon_ct_med icon=fa-flag"
