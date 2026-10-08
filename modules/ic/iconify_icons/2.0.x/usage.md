<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Iconify Icons is an icon provider for Drupal 11.1+ core Icon API: it exposes Iconify's ~200,000 open-source icons to Drupal by letting an administrator pick which Iconify collections to offer, then generating one UI icon pack per collection so editors can insert those icons anywhere the Icon API is consumed (fields, menus, CKEditor embeds via the UI Icons module).

---

The module (version 2.0.x, Drupal `>=11.1.0` only) works entirely through the core Icon API rather than shipping its own field or widget. `src/Plugin/IconExtractor/IconifyExtractor.php` registers an `iconify` extractor; `hook_icon_pack_alter()` in `iconify_icons.module` reads the collection ids stored in `iconify_icons.settings:collections` and turns each into a UI icon pack whose id is the normalized collection prefix (for example `mdi`). The settings form at `/admin/config/iconify_icons/settings` (`src/Form/Settings.php`, permission `administer site configuration`) lists every collection returned by the Iconify API as a filterable card grid; selections are saved and caches flushed so the packs rebuild. `src/IconifyApi.php` (service `iconify_icons.iconify_api`) is the HTTPS client for `api.iconify.design` — searching, listing collections (cached a day under cid `iconify_icons:collections`), listing a collection's icon slugs, and building download URLs — and `src/IconsCache.php` (service `iconify_icons.icons_cache`) can persist fetched SVGs under `public://iconify-icons/…`. Rendered icons are emitted by the generated pack template as `<img src="https://api.iconify.design/{collection}/{icon}.svg?…">`, so the browser fetches each icon straight from Iconify with size/color/flip/rotate applied as query parameters; the value a consumer stores is just the Icon-API id `pack:icon` (e.g. `mdi:home`). The recommended setup pairs this module with UI Icons (`ui_icons`, `ui_icons_field`, `ui_icons_menu`, optionally `ui_icons_text`), and the module adds a shortcut link to its settings page on those modules' configuration forms. Because icons resolve to the live Iconify API, a site with restricted egress or an upstream outage is affected, and each icon request reaches a third-party host.

---

- Expose Iconify's ~200k icons to Drupal without installing an icon font.
- Let editors pick icons for a UI Icons field.
- Add Iconify icons to menu links via `ui_icons_menu`.
- Embed Iconify icons in CKEditor text via `ui_icons_text`.
- Choose which Iconify collections a site offers.
- Limit editors to an approved set of icon collections.
- Add a whole icon pack (e.g. Material Design Icons) in one click.
- Provide a searchable, category-grouped collection picker to admins.
- Render icons as `<img>` served directly from the Iconify API.
- Recolor or resize an icon per placement (color/size/flip/rotate).
- Try several icon styles before standardizing on one.
- Give a design system a broad, consistent icon catalogue.
- Avoid shipping unused icons in a local SVG sprite.
- Fetch the live Iconify API version on the module help page.
- Cache the Iconify collections list for a day to cut API calls.
- Persist fetched SVGs to the public files directory for programmatic reuse.
- Call the Iconify search/collection API from custom code.
- Build download URLs for individual icons programmatically.
- Define a custom UI icon pack in a theme using the `iconify` extractor.
- Style the collection picker for the Gin admin theme.
- Swap or add icon collections without changing existing content.
- Set the offered collections via drush or config import.
