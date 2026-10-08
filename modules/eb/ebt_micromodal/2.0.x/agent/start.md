<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Micromodal (ebt_micromodal) — agent index

An Extra Block Types block type that renders a **trigger button opening authored content in a
[Micromodal.js](https://github.com/Ghosh/micromodal) accessible modal**. Package *Extra Block Types*.
Depends on **`ebt_core`** (project dep `ebt_core:ebt_core`). Composer also requires
`levmyshkin/micromodal:^1.0` (the JS library, loaded from `/libraries/micromodal/dist/micromodal.min.js`).
Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.0.0 (dir `2.0.x`).

- **The block type, its fields, the settings widget, templates, JS and config** →
  [blocks/micromodal-block.md](blocks/micromodal-block.md)

## What it actually is

- Installs a `block_content` bundle **`ebt_micromodal`** (label "EBT Micromodal") via
  `config/install/`, with three fields:
  - **`body`** — `text_with_summary`, rendered as the modal body (text_default formatter, format-filtered).
  - **`field_ebt_micromodal_title`** — `text_long` (own storage `field.storage.block_content.field_ebt_micromodal_title`), rendered as the modal header title.
  - **`field_ebt_settings`** — the shared `ebt_settings` field owned by `ebt_core`, edited here with this module's widget.
- One plugin: **`EbtSettingsMicromodalWidget`** (`ebt_settings_micromodal`) in
  `src/Plugin/Field/FieldWidget/EbtSettingsMicromodalWidget.php`, extending `ebt_core`'s
  `EbtSettingsDefaultWidget`. Adds `button_text`, `close_button_text` (required), `disable_scroll`
  (checkbox), `display_close_icon` (checkbox, default TRUE), plus a hidden `pass_options_to_javascript`.
- Two theme overrides: `templates/block--block-content--ebt-micromodal.html.twig` and
  `templates/block--inline-block--ebt-micromodal.html.twig` (Layout Builder inline blocks).
- `js/ebt_micromodal.js` (`Drupal.behaviors.ebtMicromodal`) calls `MicroModal.init()` per block,
  passing `disableScroll` from `drupalSettings.ebtMicromodal`.
- Library `ebt_micromodal` (in `ebt_micromodal.libraries.yml`): Micromodal min JS + `js/ebt_micromodal.js`
  + `css/micromodal.css`; deps `core/drupal`, `core/once`, `core/drupalSettings`.
- **No** routes, permissions, services, hooks (`.module`), Drush, or config schema of its own. Config
  schema for `field_ebt_settings` lives in `ebt_core`.
- `ebt_micromodal.install`: `hook_update_9001()` back-fills `display_close_icon = TRUE` on existing
  EBT Micromodal blocks.

## Operate it

- Enable: `drush en ebt_micromodal` (pulls in `ebt_core`; requires the Micromodal JS library present at
  `/libraries/micromodal/`).
- Author: Structure » Block layout » Custom block library » add **EBT Micromodal** (or add inline via
  Layout Builder). Set title + body, and the button/close labels under the **Settings** tab.
