<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories Promo Page (localgov_directories_promo_page) — agent index

Config-provider submodule of [localgov_directories](../../../../3.5.x/agent/start.md). Installs the
**`localgov_directories_promo_page`** node bundle: a paragraphs-composed directory entry.

Key facts:
- Heaviest dependency set of the entry types: `localgov_directories`, core `link`, `address`,
  `field_group`, `menu_ui`, `field_formatter_class`, and four LocalGov Paragraphs modules —
  `localgov_paragraphs`, `localgov_paragraphs_layout`, `localgov_subsites_paragraphs`,
  `localgov_paragraphs_views`. Do not enable it unless the site already runs that stack.
- Still a directory entry: carries `localgov_directory_channels` and
  `localgov_directory_facets_select`, and ships the display ids the parent module's channel view
  and Search API index expect (`directory_index`, `search_index`, `search_result`, `teaser`).
- Body content is paragraphs, not fixed fields — so what gets indexed for search depends on the
  `search_index` view display, and rich components may contribute little text. Check
  `drush cget core.entity_view_display.node.localgov_directories_promo_page.search_index` if
  entries index poorly.
- `menu_ui` support means a promo entry can sit in a menu like a normal page.
- Like the other entry submodules, it registers the bundle with `simple_sitemap` on install when
  that module is present and grants LocalGov editor/author role permissions via
  `hook_localgov_roles_default()`.
