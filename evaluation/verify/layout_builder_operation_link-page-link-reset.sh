#!/usr/bin/env bash
# Execution RESET: clear state so the "Layout" link is NOT present for the Basic page
# content type. Disables Layout Builder on article/page/blog_post default view displays
# (baseline = no LB overrides anywhere). The verify script must FAIL after this.
# Idempotent. Exits 0.
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
echo "reset: Layout Builder overrides cleared from node.page.default (no Layout link)"
