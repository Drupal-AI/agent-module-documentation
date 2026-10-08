#!/usr/bin/env bash
# Introspection SETUP: ensure formdazzle is enabled at its default weight (10) and caches are
# clear, so an agent can render a core form on the live site and read the fine-grained theme
# suggestion formdazzle injects onto a form element. No custom config needed - the suggestions
# are produced at render time from formdazzle's algorithm. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("formdazzle")) {
    \Drupal::service("module_installer")->install(["formdazzle"]);
  }
  module_set_weight("formdazzle", 10);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: formdazzle enabled at weight 10; render a form to read its theme suggestions"
