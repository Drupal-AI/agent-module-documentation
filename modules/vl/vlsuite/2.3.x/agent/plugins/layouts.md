<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite — layouts, sections & the Layout Builder operations

VLSuite does not define any custom plugin *types* (no plugin managers). It provides plugin
*instances* of core types — Layout plugins here, Block plugins in
[plugins/blocks.md](blocks.md), and a field type/widget/formatter in
[fields/content-model.md](../fields/content-model.md).

## Layout plugins (`vlsuite_layout`, `vlsuite_layout_tabs`)

Declared in `vlsuite_layout/vlsuite_layout.layouts.yml`, all in category **`VLSuite`**, base class
`Drupal\vlsuite_layout\Plugin\Layout\VLSuiteLayoutBase`:

| Layout id | Regions | Class |
|---|---|---|
| `vlsuite_layout_onecol` | top, main, bottom | `VLSuiteLayoutOneCol` |
| `vlsuite_layout_twocols` | top, first, second, bottom | `VLSuiteLayoutTwoCols` |
| `vlsuite_layout_threecols` | top, first, second, third, bottom | `VLSuiteLayoutThreeCols` |
| `vlsuite_layout_fourcols` | top, first, second, third, fourth, bottom | `VLSuiteLayoutFourCols` |

Submodule `vlsuite_layout_tabs` adds `@Layout`-annotated tab/accordion layouts:
`vlsuite_layout_tabs_horizontal` (`VLSuiteLayoutTabsHorizontal`) and `vlsuite_layout_tabs_accordion`
(`VLSuiteLayoutTabsAccordion`), base `VLSuiteLayoutTabsBase`.

### Section settings (schema `vlsuite_layout_base`)

Every VLSuite section stores (`config/schema/vlsuite_layout.schema.yml`):
`column_widths` (e.g. `50-50`, `auto` supported), `optional_regions`, `edge_to_edge`,
`edge_to_edge_bg`, `sticky`, `media_bg` (uuid of a background media), `identifier` (uuid section id
used by the identifier-based class system), plus nested `vlsuite_utility_class`, `vlsuite_slider`
(→ `vlsuite_slider_base`) and `vlsuite_animations` (→ `vlsuite_animations_base`).

`VLSuiteLayoutBase::build()` turns `column_widths` into classes by `explode('-', …)` then looking
each part up via `VLSuiteUtilityClassesHelper::getColPercentageOptionClasses()` — an unknown width
key resolves to an empty class list, so only configured `col_<n>` classes are ever emitted.
Advanced section options (`column_widths`, optional regions, edge-to-edge, edge-to-edge background)
are only exposed to users with **`use advanced vlsuite layout options`**.

Traits `VLSuiteLayoutHeadingsMenuTrait` and `VLSuiteLayoutMediaBgFieldTrait` add the headings-menu
region behaviour and the media-background field to sections.

## Layout Builder AJAX routes (VLSuite-added)

Both are gated by core's **`_layout_builder_access: 'view'`** (the same access check core uses for
its own add/move/remove operations — it requires the caller be allowed to edit that section
storage's layout) and use the `layout_builder_tempstore` param converter.

- **`vlsuite_utility_classes.apply_to`** —
  `/layout_builder/vlsuite_utility_classes/{section_storage_type}/{section_storage}/{delta}/{uuid}/{apply_to}/{identifier}/{value}`
  → `VLSuiteUtilityClassesApplyTo::layoutBuilder()`. Applies/removes one utility on a block (`uuid`)
  or the section (`uuid == _none`). The `{value}` is validated against configured utilities via
  `VLSuiteUtilityClassesHelper::checkUtilityApplyToValueIsValid()` before being written to the
  tempstore (the `_none` sentinel unsets; `column_widths` is the one identifier stored as a raw
  string but is only ever re-emitted through the `col_classes` config lookup on render). Powers the
  live-preview floating "Appearance" UI (`vlsuite_utility_classes/previewer` library).
- **`vlsuite_layout_builder.duplicate_block`** —
  `/layout_builder/duplicate/block/{section_storage_type}/{section_storage}/{delta}/{region}/{uuid}`
  → `VLSuiteLayoutBuilderDuplicate::block()`. Deep-clones an inline block component (reuses
  `section_library\DeepCloningTrait::cloneReferencedEntities()`), inserts the copy after the
  original, writes the tempstore, and rebuilds the layout. Non-inline blocks get a warning message.

## Where sections/layouts come from as reusable templates

Layouts and whole sections are made reusable through the **Section Library**
(`section_library`) contrib dependency (used by collections and the layout-library UI), and
per-layout allowed-block restrictions are enforced by **Layout Builder Restrictions**
(`layout_builder_restrictions`) — see the choose-block override in [plugins/blocks.md](blocks.md).
