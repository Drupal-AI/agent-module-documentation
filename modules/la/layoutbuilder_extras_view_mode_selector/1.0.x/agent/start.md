<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder extras – View mode selector (layoutbuilder_extras_view_mode_selector) — agent index

Improves the **view-mode picker** an editor sees when placing/editing an *inline block* in
**Layout Builder**: a site builder chooses, per block content type, *which* view modes are exposed
and gives each an icon, so the picker becomes a set of illustrated radio buttons instead of a plain
select of every machine-ish view mode. There is no admin page of its own. Two mechanisms do the
work: (1) `hook_block_alter` swaps the class of every core `inline_block:*` block plugin to
`LayoutBuilderExtrasInlineBlock` (extends core `InlineBlock`), whose `blockForm()` turns the
`view_mode` select into `radios`, drops the disabled modes, and renders each label as an `<img>`;
(2) `hook_form_block_content_type_edit_form_alter` (via `BlockContentTypeEditForm::alterForm`) adds a
"View mode icons" section to the block-type edit form and stores the choices as **third-party
settings** (`view_modes`) on the `block_content.type.*` config entity.

The stored settings are pure editorial curation: a view mode omitted here is only hidden from this
picker — it still exists and remains renderable from code, Views and other renderers. The list of
candidate view modes offered on the edit form comes from
`ViewModeSelectorHelper::getViewModesForBundle()`, which wraps
`entity_display.repository:getViewModeOptionsByBundle('block_content', $bundle)`.

- Depends on: `drupal:layout_builder` (core). No optional/soft dependencies.
- Core: `^10 || ^11`. Package: `Layout Builder`. No composer.json ships with the module.
- No settings page / `configure` route, no permissions, no drush, no routes, no controllers, no
  templates/JS/CSS. Config is per **block content type** (third-party settings), governed by core's
  "administer block content types" permission.
- Defines **no plugin type**. Defines one Block plugin (`lb_extras_inline_block`) but the runtime
  effect comes from the `hook_block_alter` class swap on core `inline_block:*`.
- Service: `layoutbuilder_extras_view_mode_selector.helper` (`ViewModeSelectorHelper`).
- **Quirk (benign):** the config schema file lives in `install/schema/` — a directory Drupal does
  NOT scan — and its top key is non-standard, so the `view_modes` third-party settings ship with no
  active schema. Purely a hygiene issue; the settings save and load fine as raw config.

## What you'd do → where

- **Expose/hide view modes and assign icons for a block type; set it from config or code** →
  [configure/view-modes.md](configure/view-modes.md)
- **Understand the class swap, the helper service, the two hooks, and the block form logic** →
  [api/internals.md](api/internals.md)

## Key facts (real machine names)

- Hooks (`layoutbuilder_extras_view_mode_selector.module`):
  `hook_block_alter` (swaps class for ids containing `inline_block:`),
  `hook_form_block_content_type_edit_form_alter`.
- Service: `layoutbuilder_extras_view_mode_selector.helper` →
  `Drupal\layoutbuilder_extras_view_mode_selector\ViewModeSelectorHelper`
  (arg `@entity_display.repository`; method `getViewModesForBundle(string $bundle)`).
- Block plugin: id `lb_extras_inline_block`, class `…\Plugin\Block\LayoutBuilderExtrasInlineBlock`
  (extends `Drupal\layout_builder\Plugin\Block\InlineBlock`, deriver core `InlineBlockDeriver`,
  category "Inline blocks", `@internal`). At runtime this class also replaces core `inline_block:*`.
- Form-alter helper class: `Drupal\layoutbuilder_extras_view_mode_selector\BlockContentTypeEditForm`
  (methods `alterForm()`, submit callback `saveForm()`); adds form element key
  `layoutbuilder_extras_view_mode_selector` (`#tree` = TRUE).
- Third-party settings provider: `layoutbuilder_extras_view_mode_selector`, key `view_modes`, stored
  on `block_content.type.<bundle>`. Per-mode keys: `view_mode_machine_name`, `view_mode_enabled`
  (bool), `view_mode_icon` (relative path string), `view_mode_icon_alt` (string).
- Config schema file (NON-standard location `install/schema/…schema.yml`, not discovered): key
  `layoutbuilder_extras_view_mode_selector.block_content.type.*.third_party.layoutbuilder_extras_view_mode_selector`.
