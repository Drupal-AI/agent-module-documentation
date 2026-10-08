<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Page Title Manage Display (entity_page_title_manage_display) — agent index

Makes an entity's page title (the core "Page title" block / H1 area) manageable through a
dedicated **`page_title`** view mode. On install it creates a "Page Title" view mode for every
entity type that has a view builder; when a bundle's `page_title` view display is configured, the
module renders the entity in that view mode and replaces the core page-title block output on the
entity's canonical/preview/revision pages. Package `Custom`. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.0-alpha2 (pre-release).

- **No dependencies** beyond Drupal core; no composer requirements.
- **No config form, no permissions, no routes, no services, no config schema.** All
  customisation happens through core's *Manage display* UI (the `page_title` view mode).
- **No plugins.** One PHP hook, one install hook, one trusted-callback render class.

## How it works, view-mode setup, and the render path
- [mechanism/render.md](mechanism/render.md) — the install hook that creates the view mode, the
  `hook_block_view_alter` targeting, the `EntityPageTitleRender::renderPageTitle` pre-render
  callback, view-mode integration, and how to enable/operate it.

## Provided code (from source)
- `entity_page_title_manage_display_install()` (`.install`) — creates an `entity_view_mode`
  `<type>.page_title` (label "Page Title") for every entity type with a view builder.
- `entity_page_title_manage_display_block_view_alter()` (`.module`) — adds the pre-render callback
  to the core `page_title_block` on `entity.*.canonical`/`.preview`/`.revision` routes.
- `Drupal\entity_page_title_manage_display\EntityPageTitleRender` (`src/EntityPageTitleRender.php`)
  — `TrustedCallbackInterface`; `renderPageTitle()` renders the routed entity in the `page_title`
  view mode and replaces the block content.
