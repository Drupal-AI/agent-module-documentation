<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text Resize — agent index

Provides a **block** (`text_resize_block`) of `+A` / `-A` (and optional reset) links that let
visitors change the on-page font size of a chosen scope. All behavior is driven by one config
object.

- **Settings, config keys, permission, block placement, theming** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Configure route `text_resize_settings` at `/admin/config/user-interface/text_resize`
  (`info.yml` `configure: text_resize_settings`), permission `administer text_resize`.
- Config object `text_resize.settings`: `text_resize_scope` (default `main`),
  `text_resize_minimum` (12), `text_resize_maximum` (25), `text_resize_reset_button` (false),
  `text_resize_line_height_allow` (false), `text_resize_line_height_min` (16),
  `text_resize_line_height_max` (36).
- Block plugin id `text_resize_block`; theme hook `text_resize_block`
  (`text-resize-block.html.twig`); front-end library `text_resize/text_resize.resize`.
- No dependencies beyond core Block, no Drush, no plugin types.
