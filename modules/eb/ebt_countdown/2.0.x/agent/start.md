<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Countdown (ebt_countdown) — agent index

Adds an **`ebt_countdown` block content type** that renders an animated FlipDown countdown to a
target date. Part of the **Extra Block Types (EBT)** family. Package `Extra Block Types`. Version
**2.0.x**. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later.

## Dependencies

- Modules: `datetime` (core), `ebt_core`, `paragraphs`.
- Composer / JS library: `levmyshkin/flipdown` (`^1.0`) — installed under `/libraries/flipdown`.
- No routes, no permissions, no services, no `.module` file, no Drush, no config **schema**
  (`field_ebt_settings` schema lives in `ebt_core`). No settings route of its own — global EBT
  options are configured by `ebt_core` at *Configuration » Content authoring » Extra Block Types
  (EBT) settings*.

## What it provides

- **Block content type** `ebt_countdown` and its default fields/displays via `config/install/`:
  - `field_ebt_countdown_date` — required `datetime` field (the target date).
  - `body` — optional formatted text.
  - `field_ebt_settings` — the shared EBT settings field (`ebt_settings` field type from `ebt_core`).
- **Field widget** `ebt_settings_countdown` (`EbtSettingsCountDownWidget`) extending `ebt_core`'s
  `EbtSettingsDefaultWidget`: adds color theme, style, and per-unit heading labels.
- **Two Twig templates** rendering the block, one **JS behavior** (`js/ebt_countdown.js`) that boots
  FlipDown, plus `ebt_countdown` and `new_year` asset libraries and CSS (`flipdown.css`,
  `new-year.css`).

## Solution docs

- Block type, fields, form/view displays, config install → [config/block-type.md](config/block-type.md)
- The settings widget, templates, JS boot and FlipDown integration →
  [fields/settings-widget.md](fields/settings-widget.md)
