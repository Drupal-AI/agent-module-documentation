<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Core — agent index

Base infrastructure for the EBT block-type ecosystem. Ships an `ebt_settings` design field
(widgets + formatter), the `field_ebt_settings` storage on `block_content`, a site-wide
settings form, CSS/JS generation, and dynamic template/theme plumbing for `ebt_*` block types.
Two submodules: `ebt_core_remove_helper`, `ebt_core_starterkit`.

- **Site-wide settings (colors, breakpoints, widths): route, config keys, defaults, scripting** →
  [configure/settings.md](configure/settings.md)
- **The `ebt_settings` field type / widgets / formatter and the per-block design options** →
  [plugins/ebt-settings-field.md](plugins/ebt-settings-field.md)
- **Services, hooks, and render/theme plumbing (`generate_css`/`generate_js`, template suggestions)** →
  [api/services-and-hooks.md](api/services-and-hooks.md)

Key facts:
- Settings: route `ebt_core.settings` at `/admin/config/content/ebt-core`; config object
  `ebt_core.settings`; permission `administer site configuration`. Default background color
  `#0d77b5`; breakpoints mobile 640 / tablet 1020 / desktop 1320.
- Field: type `ebt_settings` (widgets `ebt_settings_default`, `ebt_settings_simple`; formatter
  `ebt_settings_default`); shipped storage `field.storage.block_content.field_ebt_settings`.
- Services: `ebt_core.generate_css`, `ebt_core.generate_js`. Constants: `EbtConstants` (COLOR_BLUE `#0d77b5`).
- No permissions of its own, no Drush of its own (the generator lives in `ebt_core_starterkit`).
