<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Diboo signature pad (diboo_signature_pad) — agent index

Thin Diboo addon that makes the `diboo_image` field on the `diboo_chain_link` form mode use the `signature_pad` drawing widget, so chain-link images are hand-drawn PNGs rather than uploaded files. Installed version 1.0.1. Core `^10 || ^11`, package `Diboo`.

## Dependencies
- `diboo_core` (Diboo ecosystem base).
- `signature_pad` (supplies the `signature_pad` field widget that actually captures/saves the drawing).

## What it provides
- No entities, routes, permissions, services, config schema, config/install, install hooks, libraries, or submodules.
- One hook only: `diboo_signature_pad_entity_form_display_alter()` in `diboo_signature_pad.module`.
- No configuration UI — `configure` is null; behaviour is entirely hardcoded in the hook.

## How it works
- Guard: acts only when `$context['form_mode'] === 'diboo_chain_link'` AND the display has a `diboo_image` component; otherwise returns unchanged.
- Sets the component `type` to `signature_pad` and applies a fixed `settings` array (transparent background, `#000000` pen, `16:10` aspect ratio, `image/png`, randomized filename, `min_strokes` 10, undo/reset buttons, `jscolor` colour picker, slider size picker, `save_json_data` TRUE, alt/title/remove/image-link chrome hidden).
- Adds `third_party_settings['change_labels']` to blank the remove label and set `field_label_overwrite` to `<nolabel>`.

## Solution docs
- [Form-display alter hook](hooks/form-display-alter.md) — the single hook, its guard, and every widget setting it applies.
