#!/usr/bin/env bash
# Introspection CLEANUP: delete rm-pop-a and rm-pop-b redirects. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\redirect\Entity\Redirect;
  foreach (Redirect::loadMultiple() as $r) {
    if (in_array($r->getSource()["path"], ["rm-pop-a", "rm-pop-b"], TRUE)) { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rm-pop-a and rm-pop-b removed"
