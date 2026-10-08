#!/usr/bin/env bash
# Introspection SETUP: write a known httpswww.settings config where www is being REMOVED
# (not added) and HTTPS is left unforced, with two excluded subdomains set (though exclusions
# only take effect when prefix=yes, they are still stored and readable). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("httpswww.settings")
    ->set("enabled", TRUE)
    ->set("prefix", "no")
    ->set("scheme", "mixed")
    ->set("exclude_subdomains", ["forum", "support"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: httpswww.settings enabled=true prefix=no scheme=mixed exclude_subdomains=[forum,support]"
