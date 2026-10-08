#!/usr/bin/env bash
# Introspection SETUP: put a stub Masonry library file at the exact path the Masonry API module
# looks for (web/libraries/masonry/dist/masonry.pkgd.min.js) while deliberately leaving the
# imagesLoaded library absent, so the agent must use the module's own detection on the live site
# to say which library resolves and to what path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/imagesloaded
mkdir -p web/libraries/masonry/dist
cat > web/libraries/masonry/dist/masonry.pkgd.min.js <<'JS'
/*!
 * Masonry PACKAGED v4.2.2
 * stub file created by the masonry eval setup script
 */
JS
drush cr >/dev/null 2>&1
drush php:eval '$s = \Drupal::service("masonry.service");
print "masonry=" . var_export($s->isMasonryInstalled(), TRUE) . " imagesloaded=" . var_export($s->isImagesloadedInstalled(), TRUE) . "\n";' 2>/dev/null
echo "setup: masonry stub library present, imagesloaded absent"
