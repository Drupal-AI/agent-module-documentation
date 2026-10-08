<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Instant Preview (layout_builder_instant_preview) — agent index

Live, in-place preview for Layout Builder **custom (inline) blocks** and **layout-section
configuration** — the block/section re-renders as its off-canvas form is edited, instead of only
after Save. Version **1.1.3**. `core_version_requirement: ^9 || ^10 || ^11`. Depends only on core
**`layout_builder`**. License GPL-2.0-or-later. A fork of `panopoly_magic`, sidebar-based (no
modal), Layout-Builder-only, with CKEditor 5 support.

- **Route overrides, forms, controller, preview lifecycle and the JS behavior** →
  [architecture/route-override.md](architecture/route-override.md)
- **The one config setting and its schema** →
  [config/settings.md](config/settings.md)

## What it actually is

No routes/permissions/entities of its own. It **alters three core Layout Builder routes** via one
event subscriber and adds preview UI to two core forms plus one controller. It previews **custom
blocks only** — reusable `block_content` blocks are explicitly skipped (core previews those).

- **`src/Routing/RouteSubscriber.php`** (`RouteSubscriber extends RouteSubscriberBase`, service
  `layout_builder_instant_preview.route_subscriber`, tagged `event_subscriber`) — in
  `alterRoutes()`: points `layout_builder.add_block` at this module's controller (keeping the
  original `_title`), and swaps the `_form` of `layout_builder.update_block` and
  `layout_builder.configure_section` to this module's forms. It changes only route **defaults**,
  never `requirements`, so core Layout Builder access gating is preserved.
- **`src/Controller/LayoutBuilderAddBlockController.php`** (`::addBlock`) — a near-copy of core's
  add-block controller that, after appending the component and rebuilding the layout, renders
  **this module's** `LayoutBuilderUpdateBlockForm` into `#drupal-off-canvas`.
- **`src/Form/LayoutBuilderUpdateBlockForm.php`** (`extends
  \Drupal\layout_builder\Form\UpdateBlockForm`) — adds **Preview**, **Cancel** and an **Automatic
  preview** checkbox to a non-`block_content` block form; preview submit re-renders without
  writing to tempstore; cancel restores unchanged section storage from `tempstore.shared`.
- **`src/Form/LayoutBuilderConfigureSectionForm.php`** (`extends
  \Drupal\layout_builder\Form\ConfigureSectionForm`) — same treatment for section config, but only
  when `isUpdate` is true (configuring an existing section; add-section has no custom controller).
- **`js/layout-builder-instant-preview.js`** (library `layout_builder_instant_preview/preview`,
  `Drupal.behaviors.layoutBuilderInstantPreview`) — clicks the Preview button on `formUpdated` /
  CKEditor 5 `change:data` / Media Library reload, debounced, while the checkbox is ticked.
- **`config/schema/layout_builder_instant_preview.schema.yml`** — config object
  `layout_builder_instant_preview.settings` with one boolean, `show_enable_preview_checkbox`.

## Mechanism in one line

Preview submit calls the plugin's `submitConfigurationForm()`, applies the config to the in-memory
section/component, and returns `rebuildLayout()` — but returns **before** persisting to the Layout
Builder tempstore, so previews are ephemeral and only **Save** commits them.

## Install

```bash
composer require drupal/layout_builder_instant_preview
drush en layout_builder_instant_preview -y
```

No sub-modules, no permissions, no Drush commands, no settings UI (the one config key is set via
`drush cset` / config import — see [config/settings.md](config/settings.md)).
