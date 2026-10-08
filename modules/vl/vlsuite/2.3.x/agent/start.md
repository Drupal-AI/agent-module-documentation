<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite / Visual Layout Suite (vlsuite) — agent index

A page-building **suite on top of Layout Builder**, shipped as one project with **37 submodules**.
The parent `vlsuite` module is tiny (one help hook, one `hook_entity_view_alter`, one admin-index
route, one permission, one abstract uninstall validator); the capability lives in the submodules.
The core idea: an **identifier-based utility-class system** (`vlsuite_utility_classes`) maps abstract
appearance identifiers to concrete CSS classes so you can restyle every built component from config
(Bootstrap 5 by default) without touching content; a **code-declared bundle-field system**
(`vlsuite_bundle_field`) gives every block/media bundle its fields; VLSuite-aware **block plugins**
and **Layout plugins** carry appearance/slider/animation settings; and a live floating "Appearance"
previewer drives it all inside the Layout Builder UI via two AJAX routes.

You install this by adopting a set, not a single module — `vlsuite_shuttle` (base, no demo content)
or `vlsuite_demo` (base + example content) enable the right pieces and then auto-uninstall
themselves. This doc set documents the **suite architecture in the parent dir only** — it does not
create per-submodule doc dirs, and does not exhaustively cover all 37 submodules.

- Depends on: `drupal:layout_builder`. Composer pulls `drupal/entity`,
  `drupal/layout_builder_operation_link`, **`drupal/layout_builder_restrictions`**,
  `drupal/media_library_form_element`, **`drupal/section_library`** (all load-bearing — the block
  chooser extends Layout Builder Restrictions; collections/library use Section Library). Suggests
  `layout_builder_at`, `media_responsive_thumbnail`. Core: `^10.3 || ^11`.
- Package: `Visual Layout Suite (VLSuite)`. Settings index: `vlsuite.admin_index`
  (`/admin/config/vlsuite`). Installed & enabled at **2.3.3**.
- Permissions: `administer vlsuite settings` (`restrict access: true`) + four "advanced" appearance
  perms (`use advanced vlsuite utility classes` / `… layout options` / `… slider options` /
  `… animations options`). Provides config schema. **No plugin types, no runtime API.**
- Drush: the parent provides none; `vlsuite_generator` (experimental) adds a code generator
  `drush generate vlsuite-module`.

## What you'd do → where

- **Configure the suite: settings pages, the utility-class map, per-submodule config keys** →
  [configure/settings.md](configure/settings.md)
- **Understand layouts/sections, section options, the Layout Builder AJAX routes (apply-utility /
  duplicate-block)** → [plugins/layouts.md](plugins/layouts.md)
- **Understand the block plugins, block/collection bundles, the choose-block override** →
  [plugins/blocks.md](plugins/blocks.md)
- **Understand the content model: bundle fields, media types (incl. oEmbed remote video), the
  icon-font field, the landing node type** → [fields/content-model.md](fields/content-model.md)
- **Call the helper services, see hooks, or use the generator** → [api/services.md](api/services.md)

## Submodule map (37, grouped by family)

- **Foundation** (shared, enable these to build anything): `vlsuite_bundle_field` (code-declared
  fields), `vlsuite_utility_classes` (identifier→class map + apply route), `vlsuite_block` (block
  plugins + choose-block override), `vlsuite_layout` (4 column layouts) + `vlsuite_layout_builder`
  (duplicate-block route) + `vlsuite_layout_tabs` (tabs/accordion), `vlsuite_slider`,
  `vlsuite_animations`, `vlsuite_icon_font`, `vlsuite_media`, `vlsuite_format` (CKEditor 5 format),
  `vlsuite_modal`.
- **Block types** `vlsuite_block_*`: `_text`, `_cta`, `_image`, `_icon`, `_local_video`,
  `_remote_video`, `_attachments`, `_paragraph`, `_webform`, `_headings_menu`.
- **Collections** `vlsuite_collection*`: `vlsuite_collection` + `_card`, `_gallery`, `_hero`,
  `_stmt` (compound preset blocks, presets in the Section Library).
- **Media types** `vlsuite_media_*`: `_image`, `_document`, `_icon`, `_local_video`,
  `_remote_video` (core oEmbed).
- **Content** `vlsuite_landing` (+ `vlsuite_landing_content_editor`): the ready-to-use
  Layout-Builder landing node type + editor role.
- **Utility/setup**: `vlsuite_generator` (Drush scaffolder, experimental), `vlsuite_shuttle`
  (base setup, auto-uninstalls), `vlsuite_demo` (example content, auto-uninstalls).

## Key facts (real machine names)

- Routes: `vlsuite.admin_index`; settings `vlsuite_{utility_classes,block,animations,icon_font,
  media,modal}.settings`; `vlsuite_icon_font.autocomplete` (`_permission: access content`);
  `vlsuite_utility_classes.apply_to` & `vlsuite_layout_builder.duplicate_block`
  (`_layout_builder_access: view`).
- Layout plugins: `vlsuite_layout_onecol|twocols|threecols|fourcols`,
  `vlsuite_layout_tabs_horizontal|accordion` (category `VLSuite`).
- Block plugins: `vlsuite_block_inline_block`, `vlsuite_block_field_block`,
  `vlsuite_block_views_block`, `vlsuite_block_media_bg_block`.
- Block bundles: `vlsuite_text|cta|image|icon|local_video|remote_video|attachments|paragraph|
  webform` + collections `vlsuite_collection_card|gallery|hero|stmt`.
- Media bundles: `vlsuite_image|document|icon|local_video|remote_video`. Node type:
  `vlsuite_landing`. Text format: `vlsuite_basic_html`.
- Field: type/widget/formatter all id `vlsuite_icon_font_icon`.
- Services: `vlsuite_utility_classes.helper`, `vlsuite_animations.helper`, `vlsuite_slider.helper`,
  `vlsuite_icon_font.helper` (+ twig ext), `vlsuite_collection.helper`, `vlsuite_bundle_field.helper`,
  plus modal theme-negotiator/route-subscriber/config-override/library-collector.
- Config objects: `vlsuite_{utility_classes,block,animations,icon_font,media,modal}.settings`;
  section schema `vlsuite_layout_base`; nested `vlsuite_slider_base`, `vlsuite_animations_base`.
- Uninstall guard: abstract `Drupal\vlsuite\VLSuiteUninstallValidator` (per-bundle subclasses tagged
  `module_install.uninstall_validator`).
