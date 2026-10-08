<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Blog (webblog) — agent index

Recipe/config-bundle module (Webship "web*" suite). Version **12.0.1**, core `^11.4 || ^12`.
Almost no PHP: `webblog.install` → `webblog_install($is_syncing)` applies the bundled recipe at
`recipes/default` (guarded by `\Drupal::isConfigSyncing()` and the `$is_syncing` flag). No routes,
permissions, services, or config schema of its own; content access is plain core node +
content-moderation.

## What the recipe provisions
- **Node type** `webblog` ("Web Blog") — revisions on, preview optional, submitted-by shown, placed
  under `main` menu (`node.type.webblog.yml`).
- **Fields**: `body` (text_with_summary), `field_media` (entity_reference → image media, cardinality 1).
- **Form display** (`node.webblog.default`): title, body textarea+summary, media_library widget,
  moderation_state, path, promote/status/sticky checkboxes, authored-by/on.
- **View modes** default/teaser/full, all rendered via **Display Builder** (`display_builder` +
  `manage_display` third-party settings) — teaser uses smart_trim (200 chars, "Read more…"), full uses
  an ultrawide media rendering.
- **View** `webblogs` (`views.view.webblogs.yml`): default display + `block_webblogs_list` and
  `block_featured_webblogs` block displays. Lists published `webblog` nodes, 3-col responsive grid, 9/page,
  newest first, access `access content`. **No page display** (no listing route) — blocks must be placed.
- **Entityqueue** `featured_webblogs` (simple handler, targets `webblog` nodes) feeds the featured block.

## Dependencies (info.yml)
core `path`, `text`, `node`, `user`, `menu_ui`, `content_moderation`, `media_library`; contrib
`manage_display`, `entityqueue`, `webassets`, `display_builder` (`display_builder_entity_view`,
`display_builder_ui`). The recipe also pulls in `webdev`. Composer adds `drupal/webdev`,
`drupal/webassets`, `drupal/manage_display`, `drupal/entityqueue`, `drupal/display_builder`.

**Change vs 11.0.x**: display layer moved from Layout Builder to **Display Builder**; core requirement
bumped to `^11.4 || ^12` (adds Drupal 12).

## Solution docs
- [Recipe & provisioned config](recipes/default.md) — what installs, fields, view modes, view, queue, editor workflow.
