<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks, template override and install (views_rss_yandex.module / .install)

All non-plugin behaviour lives in `views_rss_yandex.module` and `views_rss_yandex.install`. These
are Views RSS integration hooks — they only add output to feeds; there are no routes, services,
permissions or Drush commands.

## Views RSS hooks (`views_rss_yandex.module`)

- **`hook_views_rss_namespaces()`** registers, on every views_rss feed:
  - `yandex` → prefix `xmlns`, uri `http://news.yandex.ru`
  - `media` → prefix `xmlns`, uri `http://search.yahoo.com/mrss/`
- **`hook_views_rss_item_elements()`** registers three mappable `<item>` elements:
  - `yandex:full-text` — "Full message text for search index."
  - `yandex:genre` — "Should be either lenta, message, article or interview."
  - `yandex:enclosure` — "Handles several enclosure elements per item."
  Each carries a `help` URL (`http://partner.news.yandex.ru/tech.pdf`). These appear in the Views
  RSS feed field-mapping UI; the site builder assigns a View field to each.
- **`hook_help()`** returns the module's `README.md`, HTML-escaped inside `<pre>`, on
  `help.page.views_rss_yandex`.

## Template override

- **`hook_theme_registry_alter()`** sets `$registry['views_view_row_rss']['path']` to this module's
  `templates` dir. This replaces the row template **for every views_rss feed on the site**, not
  just Yandex ones — the module ships its own copy of `views-view-row-rss.html.twig` so it can add
  the Turbo `turbo:content` branch.
- **`templates/views-view-row-rss.html.twig`** — one `<item>` per row. Standard branch mirrors the
  parent views_rss template (auto-escaped `title`/`link`/`description`; each `item_elements` entry
  rendered by its flags: `cdata` → `<![CDATA[…]]>`, `escaped` → raw pre-escaped value, iterable →
  `|render`, else auto-escaped). Turbo branch (`yandex_turbo_enabled` set) emits
  `<item turbo="true">`, `<turbo:extendedHtml>true</turbo:extendedHtml>`, and renders the
  `yandex:full-text` item inside `<turbo:content><![CDATA[ {{ item.value }} ]]></turbo:content>`.

## Preprocess (`views_rss_yandex.module`)

- **`views_rss_yandex_preprocess_views_view_row_rss()`** — sets `$variables['yandex_turbo_enabled']
  = TRUE` when `view->style_plugin->options['feed_settings']['yandex_turbo'] === 1`.
- **`views_rss_yandex_preprocess_views_view_rss()`** — on the same condition, adds the channel
  attribute `xmlns:turbo` = `http://turbo.yandex.ru` via the `Attribute` object in
  `$variables['namespaces']`.

## Config & install (`views_rss_yandex.install`, `config/install/`)

- Ships `config/install/core.date_format.rfc_822.yml` — a core **date format** entity
  (`id: rfc_822`, `label: 'RFC 822'`, `pattern: r`, `locked: false`) used for RSS `pubDate`
  formatting. No `config/schema/` and no settings form ⇒ `provides_config_schema: false`,
  `configure: null`.
- **`hook_install()`** invalidates the `views_rss` cache tag.
- **`hook_uninstall()`** invalidates the `views_rss` cache tag **and deletes** the
  `core.date_format.rfc_822` config entity (`configFactory()->getEditable(...)->delete()`).

## Access / security posture

Feed reachability and content selection are governed entirely by **Views** (display access) and
**views_rss**. This module adds no route and no access check and does not bypass any — restrict the
source View to published, public content to control what reaches Yandex.
