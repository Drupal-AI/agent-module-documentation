<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin settings, schema & install

## Install / enable

`drush en ckeditor_advanced_container` (pulls in core `ckeditor5`; no Composer libraries, no other
module deps). No configuration page is created and no content types/fields are added — the module
integrates entirely through the CKEditor 5 toolbar. Per text format at
`/admin/config/content/formats/manage/<format>`: drag the **Advanced Container** button onto the
CKEditor 5 toolbar; an **Advanced Container** settings tab then appears in that format's plugin
settings. For restricted-HTML formats the plugin's elements subset already contributes the required
`<div class="advanced-container">` / `<div class="advanced-column">` signatures plus a `<div class>`
wildcard, so no manual "Allowed HTML tags" editing is needed.

## The CKEditor 5 plugin

Declared purely via the `@CKEditor5Plugin` annotation on
`src/Plugin/CKEditor5Plugin/AdvancedContainer.php` (there is no `*.ckeditor5.yml`):

- plugin id `ckeditor_advanced_container_container`; CKEditor JS plugin
  `advancedContainer.AdvancedContainer`; toolbar item `advancedContainer` (label "Advanced Container").
- `library = ckeditor_advanced_container/ckeditor5.container` (the split editor JS),
  `admin_library = ckeditor_advanced_container/admin` (editor CSS).
- PHP class extends `CKEditor5PluginDefault` and implements `CKEditor5PluginConfigurableInterface`
  (settings form) + `CKEditor5PluginElementsSubsetInterface` (dynamic allowed elements).

## Settings

Stored under `settings.plugins.ckeditor_advanced_container_container.*`. Schema
`config/schema/ckeditor_advanced_container.schema.yml`
(`ckeditor5.plugin.ckeditor_advanced_container_container`). Note the code `defaultConfiguration()`
differs from the README's stated defaults for two keys (`default_columns`, `auto_stack_mobile`
description aside) — the table below reflects the **PHP source**:

| key | type | code default | notes / bounds |
|-----|------|--------------|----------------|
| `default_columns` | integer | **1** | `#type number`, min 1 / max 12; new container's column count |
| `default_gap` | string | `''` (empty) | free-text CSS dimension, empty = no gap |
| `enable_responsive` | boolean | **TRUE** | show per-device (mobile/tablet/desktop) fields by default |
| `auto_stack_mobile` | boolean | **TRUE** | new containers stack columns under 768px |
| `auto_stack_tablet` | boolean | FALSE | also stack 768–1023px |
| `max_nesting_depth` | integer | **3** | min 0 / max 10; `0` = unlimited |
| `enable_click_to_insert` | boolean | FALSE | click a column's top/bottom padding inserts a temp paragraph |

(README documents `default_columns` default 2 and `enable_click_to_insert` default on; the shipped
`AdvancedContainer::defaultConfiguration()` uses 1 and FALSE respectively — source is authoritative.)

## Server-side validation

`validateConfigurationForm()`:
- `default_columns` must be 1–12 (error otherwise).
- `default_gap`, if non-empty, must match a strict CSS-dimension regex —
  `^(\d+\.?\d*|\.\d+)(px|em|rem|%|vw|vh|vmin|vmax|ch|ex|cm|mm|in|pt|pc)(\s+…)?$` — accepting one or two
  space-separated dimensions (row/column gap). Anything else is rejected. This is the one server-side
  guard; per-element spacing/color values entered in the editor balloons are validated client-side (see
  [../reference/markup.md](../reference/markup.md)).

`submitConfigurationForm()` casts each value (`(int)`, `trim()`, `(bool)`) before storing.

## Dynamic config passed to the browser

`getDynamicPluginConfig()` forwards all seven settings to the JS plugin under the
`advancedContainer` config key (`defaultColumns`, `defaultGap`, `enableResponsive`, `autoStackMobile`,
`autoStackTablet`, `maxNestingDepth`, `enableClickToInsert`). No secrets are involved — these are
purely layout defaults.
