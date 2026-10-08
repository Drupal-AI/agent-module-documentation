#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline by disabling Layout Builder on the
# article, page, and blog_post default view displays (baseline = no LB overrides
# anywhere). Idempotent: no-op where already disabled. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  foreach (["article","page","blog_post"] as $b) {
    $d = $repo->getViewDisplay("node", $b, "default");
    if ($d && !empty($d->getThirdPartySettings("layout_builder")["enabled"] ?? NULL)) { $d->disableLayoutBuilder()->save(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: Layout Builder disabled on article/page/blog_post view displays (baseline restored)"
