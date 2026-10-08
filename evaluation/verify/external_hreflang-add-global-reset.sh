#!/usr/bin/env bash
# Execution RESET: remove any External Hreflang value from the global metatag defaults so verify
# FAILS until the agent adds the required alternate. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("metatag_defaults")->load("global");
  if ($d) { $tags = $d->get("tags") ?: []; unset($tags["hreflang_external"]); $d->set("tags", $tags)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: global tags.hreflang_external cleared"
