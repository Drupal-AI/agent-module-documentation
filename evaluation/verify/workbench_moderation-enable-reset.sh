#!/usr/bin/env bash
# Execution RESET: ensure moderation is OFF on Article so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $t->unsetThirdPartySetting("workbench_moderation","enabled");
  $t->unsetThirdPartySetting("workbench_moderation","allowed_moderation_states");
  $t->unsetThirdPartySetting("workbench_moderation","default_moderation_state");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: Article moderation disabled"
