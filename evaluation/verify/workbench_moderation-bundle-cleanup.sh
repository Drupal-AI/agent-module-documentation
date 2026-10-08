#!/usr/bin/env bash
# Introspection CLEANUP: turn moderation back off on Article (remove third-party settings). Exit 0.
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
echo "cleanup: Article moderation disabled (baseline restored)"
