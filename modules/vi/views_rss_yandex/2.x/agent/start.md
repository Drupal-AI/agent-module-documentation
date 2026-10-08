<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS: Yandex Elements (views_rss_yandex) — agent index

Extends **Views RSS** with the **Yandex/Dzen** XML namespaces and item elements, plus an optional
**Yandex Turbo** feed style. Version 2.0.2. Package `Views`. License GPL-2.0-or-later. Core
`^9 || ^10 || ^11`. Depends on `views_rss:views_rss` and `views_rss:views_rss_core` (info.yml).
Composer requires `drupal/views_rss:^2.0`.

- **The Views style plugin and its Yandex Turbo toggle** → [plugins/rss_fields_yandex.md](plugins/rss_fields_yandex.md)
- **The namespace/element hooks, template override and install behavior** → [api/hooks.md](api/hooks.md)

## What it actually is (from source)

- **One Views style plugin:** `RssFieldsYandex` (id **`rss_fields_yandex`**, title *"Yandex RSS
  Feed - Fields"*, `display_types = ["feed"]`, theme `views_view_row_rss`) in
  `src/Plugin/views/style/RssFieldsYandex.php`, **extends** views_rss's `RssFields`. Adds a
  single feed option `feed_settings.yandex_turbo` (checkbox "Enable yandex turbo for this feed").
- **Four hook_views_rss_* implementations** in `views_rss_yandex.module` register Yandex output —
  no new plugin type, no routes, no services, no permissions, no Drush.
  - `hook_views_rss_namespaces()` → `xmlns:yandex` (`http://news.yandex.ru`) and `xmlns:media`
    (`http://search.yahoo.com/mrss/`).
  - `hook_views_rss_item_elements()` → item elements **`yandex:full-text`**, **`yandex:genre`**,
    **`yandex:enclosure`** (mappable to Views fields in the Views RSS feed settings).
- **Template override:** `hook_theme_registry_alter()` repoints the `views_view_row_rss` theme
  hook to **this module's** `templates/views-view-row-rss.html.twig` (site-wide, for every
  views_rss feed) so it can emit the Turbo `turbo:content` wrapper.
- **Preprocess:** `views_rss_yandex_preprocess_views_view_row_rss()` sets `yandex_turbo_enabled`
  per row; `views_rss_yandex_preprocess_views_view_rss()` adds the `xmlns:turbo`
  (`http://turbo.yandex.ru`) namespace to the channel — both only when `yandex_turbo === 1`.
- **Config:** ships `config/install/core.date_format.rfc_822.yml` (an RFC 822 date format entity,
  pattern `r`, id `rfc_822`) used for RSS `pubDate`. **No** config/schema, **no** settings form,
  `configure` route = null. `hook_uninstall()` deletes that date format and invalidates the
  `views_rss` cache tag.

## Operate it

1. `drush en views_rss_yandex -y` (pulls in views_rss + views_rss_core).
2. Create a View with a **Feed** display; set its format/style to **"Yandex RSS Feed - Fields"**
   (or the plain views_rss "RSS Feed - Fields" — the namespaces/elements are registered either
   way). Map fields to `yandex:full-text` / `yandex:genre` / `yandex:enclosure` under the feed's
   field settings.
3. Tick **"Enable yandex turbo for this feed"** in the style's *Feed settings* to emit a Turbo
   feed. Feed access is governed entirely by Views + views_rss — restrict the View to published,
   public content.
