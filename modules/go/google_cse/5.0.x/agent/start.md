<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# google_cse — agent start

Embeds **Google Programmable Search** (formerly Custom Search Engine, "CSE") into Drupal.
It is **not** a Search API/Solr backend — Google hosts the index and serves results. The
module adds a **core Search page plugin** `google_cse_search` (a
`ConfigurableSearchPluginBase`) and a **block** `google_cse`. You register a Programmable
Search Engine at Google, then create a core Search page (`/admin/config/search/pages`)
using the plugin and paste in the engine's **Search Engine ID (`cx`)**. Depends only on
core `search`. Package: none.

**Where config lives (important):** there is **no `google_cse.settings` object**. The
plugin's settings are stored **inside a `search.page.<id>` config entity** under the
`configuration:` map (schema `search.plugin.google_cse_search`). The `cx` id and all other
options are `configuration.<key>` on that search page entity. The module has **no configure
route of its own** (no `*.routing.yml`, no `configure:` in info.yml) — you configure it
through core's Search pages UI (`entity.search_page.edit_form`).

**Live-search limitation:** actually returning results needs a real Google Programmable
Search Engine and the visitor's browser running Google's script. In a bare test
environment you can create and read the config, but no live results come back — ground any
verification in **config only**.

- Search page config entity, all `configuration.*` keys (`cx`, `results_display`, `custom_results_display`, `query_key`, `watermark`, prefix/suffix, width, custom CSS, data-attributes), drush recipes → [configure/search-page.md](configure/search-page.md)
- The `google_cse_search` search plugin, the `google_cse` block, the core-search-block redirect behaviour, permission → [plugins/search-and-block.md](plugins/search-and-block.md)
