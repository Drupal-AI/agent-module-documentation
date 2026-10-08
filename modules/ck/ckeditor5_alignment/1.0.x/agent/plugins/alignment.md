<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 plugin: ckeditor5_alignment_alignment

Defined entirely in `ckeditor5_alignment.ckeditor5.yml`. The module contributes this one CKEditor 5 plugin and nothing else (no PHP class backs it — it uses core's built-in JS plugin).

## Definition (from `ckeditor5_alignment.ckeditor5.yml`)

Plugin id: `ckeditor5_alignment_alignment`

- `ckeditor5.plugins`: `- alignment.Alignment` — loads CKEditor 5's built-in Alignment plugin (not a custom one).
- `ckeditor5.config.alignment.options`: four options, each a `{name, className}` pair:
  - `left` → `text-align-left`
  - `center` → `text-align-center`
  - `right` → `text-align-right`
  - `justify` → `text-align-justify`
  - (Class names match `core/modules/system/css/components/align.module.css`.)
- `drupal.label`: `Alignment`
- `drupal.library`: `core/ckeditor5.alignment` (front-end editor library, from core).
- `drupal.admin_library`: `ckeditor5/internal.admin.alignment` (toolbar-builder admin UI, from core).
- `drupal.toolbar_items`: four independent items, each with a `label`:
  - `alignment:left` → "Align Left"
  - `alignment:center` → "Align Center"
  - `alignment:right` → "Align Right"
  - `alignment:justify` → "Justify"
- `drupal.elements`:
  `<$text-container class="text-align-left text-align-center text-align-right text-align-justify">`
  This is the GHS/allowed-elements declaration: it permits **only** those four CSS classes on text-container (block-level) elements. `$text-container` is CKEditor 5's token for editable block containers; no new HTML tags and no `style` attribute are introduced.

## How the four buttons differ from core

Core's own alignment plugin registers a single split-button/dropdown toolbar item (`alignment`). This module declares four separate `toolbar_items` (`alignment:left`, etc.) so a site builder can place each alignment action as its own top-level button. Both use the same underlying `alignment.Alignment` JS plugin and the same `text-align-*` classes, so output HTML is identical to core's.

## Install & enable

1. `drush en ckeditor5_alignment` (or via the Extend UI). Requires core `ckeditor5`.
2. Go to `/admin/config/content/formats`, edit a text format/editor that uses **CKEditor 5**.
3. In the toolbar builder, drag the desired **Align Left / Align Center / Align Right / Justify** buttons from Available to Active.
4. Ensure the text format's HTML filter permits the `text-align-*` classes on block elements (CKEditor 5's "Manually editable HTML tags" / the editor's own element negotiation handles this via the plugin's `elements` declaration; the text-format **filter remains the output boundary**).
5. Save. Editors now see individual alignment buttons.

## Notes for agents

- There is **no settings form and no route** — all configuration is the per-format toolbar/editor config stored under `editor.editor.<format>` and `filter.format.<format>`.
- Removing the module: remove the buttons from any editor toolbars first, then uninstall, to avoid an editor config referencing a missing toolbar item.
- Output is class-only on block containers; rendering/escaping of editor content is handled by core's text-format filter pipeline, not by this module.
