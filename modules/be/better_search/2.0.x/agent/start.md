<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Search Block — agent index

Themes Drupal's core search block (and optionally the search-results page form) with a
placeholder, an icon, and one of four CSS hover animations. Pure `hook_form_alter()` + CSS —
no block, plugin, entity, or schema. Config lives in `better_search.settings`; the settings
form is route `better_search_settings` (`/admin/config/search/better-search`), gated by the
`administer Better Search settings` permission.

- **All settings keys, the config form, and how the alter works** →
  [configure/settings.md](configure/settings.md)
- **The four animation styles / CSS libraries and the icon markup** →
  [theming/styles.md](theming/styles.md)

Key facts:
- `theme` is an integer 0–3: 0 background fade, 1 expand on hover, 2 expand icon on hover,
  3 slide icon on hover — each maps to a `better_search/<library>` CSS library.
- The alter fires for the form id in `block_form_id` (default `search_block_form`) and core's
  `search_form`; change `block_form_id`/`input_name` to target a different search form.
