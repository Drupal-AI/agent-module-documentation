<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Show More Pager — agent index

Adds a Views **pager plugin** `show_more` ("Show more pager"): a load-more button instead of
numbered pages, with a separate first-page item count. Works AJAX and non-AJAX (built for AJAX).
Requires core `views`. **No settings page, routes, permissions, or Drush** — configured in the
view's Pager section; stored in the view display's pager options.

- **The `show_more` pager plugin: every option + the initial/per-click LIMIT logic** →
  [plugins/show-more-pager.md](plugins/show-more-pager.md)
- **The JS library, the AJAX response subscriber, and the pager template** →
  [theming/template-and-js.md](theming/template-and-js.md)

Key facts:
- Pager plugin id `show_more` (extends core `SqlBase`). Theme `views_show_more_pager`.
- Options (schema `views.pager.show_more`): `show_more_text` (default "Show more"),
  `result_display_method` (`append` | `html` = Replace), `initial` (first-page count; `0` = same
  as items-per-page), `items_per_page` (per click), plus `effects` (animation) and `advance`
  (selectors, default content `.view-content`, pager `.pager-show-more`).
- Stored at `views.view.<id>` → `display.<d>.display_options.pager` with `type: show_more`.
