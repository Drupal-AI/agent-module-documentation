<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Button Modal (block_button_modal) — agent index

Renders a placed block as a **button** that opens the block's own content in a core modal dialog.
Pure display helper: **no routes, no permissions, no services, no plugins, no PHP classes** — only
procedural hooks in `block_button_modal.module`, a Twig template, config schema, and one JS behavior.
Depends only on core **`block`**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.1.1.

- **How it works (hooks, third-party setting, theme, JS) and how to enable it per block** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- `hook_form_block_form_alter` adds a checkbox `third_party_settings[block_button_modal][enabled]`
  ("Show block as modal dialog") to the block config form, defaulting to FALSE.
- `hook_block_view_alter` (via `hook_ENTITY_TYPE_view_alter`) — when that setting is enabled — swaps
  `$build['#theme']` to `block_button_modal_block` and copies the block label into `#block_label`.
- `hook_theme` registers `block_button_modal_block`; template
  `templates/block-button-modal-block.html.twig` renders a `#type => button` (label = block label)
  plus the block content wrapped in `.block-button-modal-block-wrapper` with a unique container id.
- `js/block_button_modal_block.js` (`Drupal.behaviors.block_button_modal_block`) attaches
  `Drupal.dialog(#<block-id>, {title, width:'100%'})` and shows it modally on button click.
- Config schema `block.block.*.third_party.block_button_modal` (one boolean `enabled`).
- Library `block_button_modal/block_button_modal_block` (deps `core/drupal`, `core/drupal.dialog`).

## Notes

- No admin settings route (`configure` is null); everything is per-block on the block form.
- Block content is rendered into the page normally — the module only relocates already-rendered,
  access-checked output into a client-side dialog. No content is fetched at modal-open time.
- Provides theme suggestions `block_button_modal_block__<id>`, `input__block_button_modal`,
  `input__block_button_modal_block_<id>` for per-block theming.
