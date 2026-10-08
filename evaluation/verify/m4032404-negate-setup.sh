#!/usr/bin/env bash
# Introspection SETUP: exclude /blog/* from the 403->404 behaviour (negate=true = do-not-redirect list).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("m4032404.settings")
    ->set("admin_only", FALSE)->set("pages", ["/blog/*"])->set("negate", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pages=[/blog/*] negate=TRUE (excluded from redirect)"
