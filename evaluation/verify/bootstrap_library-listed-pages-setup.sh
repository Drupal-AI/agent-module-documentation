#!/usr/bin/env bash
# Introspection SETUP: flip bootstrap_library to "only the listed pages" and pin the list to
# two distinctive paths, so the agent must read bootstrap_library.settings from the live site
# to say where Bootstrap loads. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("url.visibility", 1)
    ->set("url.pages", ["/bl-eval-landing", "/bl-eval-landing/*"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: bootstrap_library url.visibility=1, url.pages=/bl-eval-landing + /bl-eval-landing/*"
