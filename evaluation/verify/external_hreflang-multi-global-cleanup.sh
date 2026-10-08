#!/usr/bin/env bash
# Introspection CLEANUP: remove the External Hreflang key from the global metatag defaults. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("metatag_defaults")->load("global");
  if ($d) { $tags = $d->get("tags") ?: []; unset($tags["hreflang_external"]); $d->set("tags", $tags)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: global tags.hreflang_external removed"
