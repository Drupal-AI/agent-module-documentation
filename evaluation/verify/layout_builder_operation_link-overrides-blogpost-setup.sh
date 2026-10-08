#!/usr/bin/env bash
# Introspection SETUP: enable Layout Builder WITH per-entity overrides on the
# node.blog_post default view display, so this module adds the "Layout" operation
# link for Blog post nodes. An inspecting agent should read the live config and
# discover that `blog_post` is the (only) content type with overrides enabled.
# Idempotent: first clears LB from article/page/blog_post, then enables on blog_post.
# Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  foreach (["article","page","blog_post"] as $b) {
    $d = $repo->getViewDisplay("node", $b, "default");
    if ($d && !empty($d->getThirdPartySettings("layout_builder")["enabled"] ?? NULL)) { $d->disableLayoutBuilder()->save(); }
  }
  $d = $repo->getViewDisplay("node", "blog_post", "default");
  $d->enableLayoutBuilder()->setOverridable()->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Layout Builder overrides ENABLED on node.blog_post.default (Blog post now shows the Layout operation link)"
