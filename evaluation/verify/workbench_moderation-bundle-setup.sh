#!/usr/bin/env bash
# Introspection SETUP: enable workbench moderation on the Article node type with default
# state needs_review. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $t->setThirdPartySetting("workbench_moderation","enabled",TRUE);
  $t->setThirdPartySetting("workbench_moderation","allowed_moderation_states",["draft","needs_review","published","archived"]);
  $t->setThirdPartySetting("workbench_moderation","default_moderation_state","needs_review");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Article moderated, default_moderation_state=needs_review"
