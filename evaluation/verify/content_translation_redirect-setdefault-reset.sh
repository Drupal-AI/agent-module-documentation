#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore the Default redirect to disabled (code null) so verify FAILS
# until the agent sets a code. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("content_translation_redirect.entity.default")
    ->set("code", NULL)->set("path", "")->set("mode", "translatable")->save();
' >/dev/null 2>&1
echo "reset: Default redirect code=null (disabled)"
