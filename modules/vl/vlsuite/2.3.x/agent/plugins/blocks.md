<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite — block plugins, block types & collections

The `vlsuite_block` submodule is the block foundation every `vlsuite_block_*` and
`vlsuite_collection_*` submodule builds on. It ships four core-type `@Block` plugins (with
derivers), a route override for the Layout Builder block chooser, and a base bundle class.

## Block plugins (`vlsuite_block/src/Plugin/Block/`)

| Plugin id | Class | Deriver |
|---|---|---|
| `vlsuite_block_inline_block` | `VLSuiteInlineBlock` | core `InlineBlockDeriver` |
| `vlsuite_block_field_block` | `VLSuiteFieldBlock` | `VLSuiteFieldBlockDeriver` |
| `vlsuite_block_views_block` | `VLSuiteViewsBlock` | `VLSuiteViewsBlockDeriver` |
| `vlsuite_block_media_bg_block` | `VLSuiteMediaBgFieldBlock` | `VLSuiteMediaBgFieldBlockDeriver` |

These are VLSuite-aware variants of Layout Builder's inline/field/views blocks: they carry the
`vlsuite_utility_class`, `vlsuite_slider` and `vlsuite_animations` settings so editors can style,
slide and animate them. **Editors must place the `vlsuite_*` block variants, not the core ones**, or
the VLSuite appearance/slider options never appear (called out in the README). Block config schema
lives in `vlsuite_block/config/schema/vlsuite_block.schema.yml`
(`block.settings.vlsuite_block_field_block:*:*:*`, `…inline_block:*`, `…views_block:*`).

`VLSuiteMediaBgFieldBlock` reads a media entity id from its configured field and renders it as a
section/block background (media types allowed as backgrounds are gated by `vlsuite_media.settings`).

## Choose-block override (route subscriber)

`VLSuiteBlockRouteSubscriber` (event_subscriber) rewrites the controller of core route
`layout_builder.choose_block` to `VLSuiteBlockChooseBlockController::build`. That controller
**extends `layout_builder_restrictions\Controller\ChooseBlockController`** (hence the hard
dependency on Layout Builder Restrictions) and adds icon/thumbnail rendering (per-block-type `icon`
uuid stored in `block_content.type.*.third_party.vlsuite_block`) to the block picker.

## Block content types (bundles)

Each is a `block_content` bundle installed as optional config by its submodule. Basic blocks
(`vlsuite_block_*`):

- `vlsuite_text`, `vlsuite_cta`, `vlsuite_image`, `vlsuite_icon`, `vlsuite_local_video`,
  `vlsuite_remote_video`, `vlsuite_attachments`, `vlsuite_paragraph`, `vlsuite_webform`.
- `vlsuite_block_headings_menu` provides no bundle — it auto-builds an in-page anchor menu from the
  `h1…h6` in the sibling region (needs the field HTML format to allow `id` on headings, e.g.
  `vlsuite_basic_html`). Its block plugin lives in
  `vlsuite_block/modules/vlsuite_block_headings_menu/src/Plugin`.

Compound **collection** blocks (`vlsuite_collection_*`, each depends on `vlsuite_block` +
`vlsuite_layout` + `section_library` + `vlsuite_bundle_field`):

- `vlsuite_collection_card`, `vlsuite_collection_gallery`, `vlsuite_collection_hero`,
  `vlsuite_collection_stmt` (statement/quote).

Collections ship preset variants inside the Section Library ("glossaries") as a starting point;
per the submodule description, presets are an *adjustable base* — later suite updates never
re-apply changes to your customised bundles or content.

## Bundle classes & the appearance pipeline

Bundles use entity bundle classes rooted at `VLSuiteBlockBase`
(`vlsuite_block/src/Entity/Bundle/`); e.g. `VLSuiteBlockRemoteVideo` mixes in the remote-video
bundle-field trait (see [fields/content-model.md](../fields/content-model.md)). At render time
`VLSuiteUtilityClassesHelper::buildApplyUtilityClasses()` walks the block/field build array and
merges the configured utility classes onto `#attributes`/`#item_attributes`; classes always come
from config, never from raw request input.
