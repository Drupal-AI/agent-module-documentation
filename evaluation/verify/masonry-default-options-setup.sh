#!/usr/bin/env bash
# Introspection SETUP: guarantee the known baseline this case asks about - no Masonry/imagesLoaded
# stub libraries on disk and no Lazy module overriding the lazyload class names - so the defaults
# returned by MasonryService::getMasonryDefaultOptions() are the module's own. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/masonry web/libraries/imagesloaded
rmdir web/libraries 2>/dev/null || true
drush cr >/dev/null 2>&1
drush php:eval '$o = \Drupal::service("masonry.service")->getMasonryDefaultOptions();
print "gutterWidth=" . var_export($o["gutterWidth"], TRUE)
  . " layoutAnimationDuration=" . var_export($o["layoutAnimationDuration"], TRUE)
  . " imageLazyloadSelector=" . var_export($o["imageLazyloadSelector"], TRUE) . "\n";' 2>/dev/null
echo "setup: baseline masonry defaults in place (no stub libraries, lazy module absent)"
