#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval-intro-src redirect, restoring baseline.
# Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("redirect");
  foreach ($storage->loadByProperties(["redirect_source__path" => "eval-intro-src"]) as $r) { $r->delete(); }
  foreach ($storage->loadMultiple() as $r) {
    if (ltrim($r->getSourcePathWithQuery(), "/") === "eval-intro-src") { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: redirect eval-intro-src removed"
