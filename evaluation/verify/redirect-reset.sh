#!/usr/bin/env bash
# Reset the redirect eval to a clean, known baseline between runs so each condition is
# independent: delete every redirect entity whose source path is `eval-old-page`, then
# rebuild caches. Mirrors pathauto-reset.sh but operates on redirect storage, querying
# by the redirect_source path.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("redirect");
  $matches = $storage->loadByProperties(["redirect_source__path" => "eval-old-page"]);
  foreach ($matches as $r) { $r->delete(); }
  // Belt-and-suspenders: also catch any stragglers via getSourcePathWithQuery().
  foreach ($storage->loadMultiple() as $r) {
    if (ltrim($r->getSourcePathWithQuery(), "/") === "eval-old-page") { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: redirects for source 'eval-old-page' deleted, caches rebuilt"
