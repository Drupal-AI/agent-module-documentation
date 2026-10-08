#!/usr/bin/env bash
# Introspection CLEANUP: delete the rm-known-src redirect created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\redirect\Entity\Redirect;
  foreach (Redirect::loadMultiple() as $r) {
    if ($r->getSource()["path"] === "rm-known-src") { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: redirect rm-known-src removed"
