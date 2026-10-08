#!/usr/bin/env bash
# MEDIUM introspection setup: store a KNOWN Sentry environment tag in raven.settings
# so the agent must inspect the live site to answer.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("raven.settings")
    ->set("environment", "staging-eval-7421")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: raven.settings environment = staging-eval-7421"
