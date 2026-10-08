<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Tips — agent index

Moves Drupal form-element **descriptions into JavaScript tooltips** (hover or click) on every
non-admin page. Pure client-side: one config object `formtips.settings`, one settings form, no
plugins/services/entities. Attached via `hook_page_bottom()` as the `formtips/formtips` library
plus a `drupalSettings.formtips` payload.

- **All settings keys, the settings form, and how they map to behavior** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object: `formtips.settings`. Configure route: `formtips.setting_form` →
  `/admin/config/user-interface/formtips` (permission `administer formtips`).
- Trigger: `formtips_trigger_action` = `click` (default) or `hover`. Tooltip width:
  `formtips_max_width` (default `'500px'`).
- Exclude fields: `formtips_selectors` (newline-separated CSS/jQuery selectors).
- Theme allow-list: `formtips_themes` (empty `{}` = all themes).
- Hover-only tuning: `formtips_hoverintent`, `formtips_interval`, `formtips_sensitivity`,
  `formtips_timeout`.
- If `form_placeholder` is enabled, its library is auto-added as a dependency
  (`hook_library_info_alter()`).
