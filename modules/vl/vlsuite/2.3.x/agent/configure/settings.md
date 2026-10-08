<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite — settings pages & config objects

Every VLSuite settings page lives under `/admin/config/vlsuite` and is gated by the single suite
permission **`administer vlsuite settings`** (`restrict access: true`). The index route
`vlsuite.admin_index` (`/admin/config/vlsuite`) is just core's
`SystemController::systemAdminMenuBlockPage` — it renders links to whatever per-submodule settings
routes are enabled. There is **no single monolithic settings form**; each foundational submodule
ships its own form + config object.

## Settings routes (all `_permission: 'administer vlsuite settings'`)

| Route | Path | Form class | Config object |
|---|---|---|---|
| `vlsuite_utility_classes.settings` | `/admin/config/vlsuite/utility-classes` | `VLSuiteUtilityClassesSettingsForm` | `vlsuite_utility_classes.settings` |
| `vlsuite_block.settings` | `/admin/config/vlsuite/block` | `VLSuiteBlockSettingsForm` | `vlsuite_block.settings` |
| `vlsuite_animations.settings` | `/admin/config/vlsuite/animations` | `VLSuiteAnimationsSettingsForm` | `vlsuite_animations.settings` |
| `vlsuite_icon_font.settings` | `/admin/config/vlsuite/icon-font` | `VLSuiteIconFontSettingsForm` | `vlsuite_icon_font.settings` |
| `vlsuite_media.settings` | `/admin/config/vlsuite/media` | `VLSuiteMediaSettingsForm` | `vlsuite_media.settings` |
| `vlsuite_modal.settings` | `/admin/config/vlsuite/modal` | `VLSuiteModalSettingsForm` | `vlsuite_modal.settings` |

Two additional routes are **not** admin settings forms (see [plugins/layouts.md](../plugins/layouts.md)):
- `vlsuite_icon_font.autocomplete` — `/vlsuite/icon-font/autocomplete` (`_permission: 'access content'`), JSON icon-name autocomplete used by the icon-font widget.
- `vlsuite_utility_classes.apply_to` and `vlsuite_layout_builder.duplicate_block` — Layout Builder AJAX operations (`_layout_builder_access: 'view'`).

## The utility-classes model (`vlsuite_utility_classes.settings`)

This is the heart of the suite. It maps an abstract **identifier** to concrete CSS **classes**, so
you can re-skin every previously built component by changing config instead of editing content.
Schema type `vlsuite_utility_classes_utility` (`config/schema/vlsuite_utility_classes.schema.yml`):

- `utilities` — sequence keyed by identifier. Each has `visual_name`, `icon`, `advanced` (bool —
  hidden unless the user has `use advanced vlsuite utility classes`), `class_prefix`,
  `apply_to` (sequence of apply-to targets), and `values` (each value has `visual_name`, `icon`,
  `class_suffix`). Rendered class = `class_prefix . class_suffix` (`getUtilityKeyValueClasses()`).
- `col_classes` — sequence keyed `col_<percentage>` (e.g. `col_50`) → space-separated grid classes.
- `container_classes`, `row_classes`, `list_unstyled_classes` — theme wrapper classes.
- `column_widths_icon`, `column_widths` — floating-UI icon + default width string (`50-50`, etc.).

Defaults ship Bootstrap 5 classes; on a non-Bootstrap theme you retune these strings only.

## Other config objects (keys)

- `vlsuite_block.settings` — `utility_classes_apply_to_enabled` (per block type: which fields /
  inline block expose the Appearance UI).
- `vlsuite_animations.settings` — `animations` (sequence of `{apply_at, visual_name, classes}`),
  plus `is_playing_classes`, `is_shown_classes`, `infinite_classes`, `main_classes`, `root_margin`,
  `threshold` (IntersectionObserver-driven scroll animations).
- `vlsuite_icon_font.settings` — `font` (uri), `list` (newline-separated icon class names),
  `main_classes`, `replacement` (`text`|`class`).
- `vlsuite_media.settings` — `bg_types`, `media_types` (bool maps of which media types may be used
  as section/block backgrounds and generally).
- `vlsuite_modal.settings` — `modal_width`, `modal_height`, `modal_autoresize`,
  `layout_builder_enabled`, `layout_builder_admin_inherited`.
- `vlsuite_slider.settings` has no top-level config object; slider options are stored per-section /
  per-block (`vlsuite_slider_base` schema: `active`, `scope`, `slides_per_view*`, `space_between`,
  `loop`, `autoplay`, `navigation`, `pagination`, …).

## Config the suite installs (`config/optional/`)

- Parent: two node view modes `vlsuite_full_content_top` / `vlsuite_full_content_bottom`
  (core.entity_view_mode.node.*), consumed by `hook_entity_view_alter()` in `vlsuite.module`.
- `vlsuite_format`: `filter.format.vlsuite_basic_html` + `editor.editor.vlsuite_basic_html`
  (a CKEditor 5 "Basic HTML (VLSuite)" format that permits `id` on heading tags — required for the
  Headings Menu block anchors).
- Media/block/collection submodules install their own bundle, field, form-display and view-display
  config as **optional** so a customised install keeps its edits (updates never overwrite).
