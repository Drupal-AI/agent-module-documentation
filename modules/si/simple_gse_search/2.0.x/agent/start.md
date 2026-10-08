<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple GSE Search (simple_gse_search) — agent index

Integrates Google Programmable Search Engine (Custom Search Engine, "CSE") using Google's
client-side JavaScript approach: you store one value — the CSE id (`cx`) — place the search
block, and Google's `cse.js` renders the box and results in the browser. There is no API key
and no server-side call to Google; the site only holds the public `cx` identifier. Core-only
dependency; `core_version_requirement: ^8.8 || ^9 || ^10 || ^11`, `package: Search`.

No `configure:` key in the info file, so no Configure link appears on the Extend page; the
settings form is route `simple_gse_search.admin_settings` (`/admin/config/search/simple_gse_search`).
Defines 2 permissions, 1 block plugin, config schema. No drush commands, no plugin types.

- **Set the Google CSE id (`cx`) and how the embed works** → [configure/settings.md](configure/settings.md)
- **Place the search box + the `/search` results page (block, form)** → [blocks/search_block.md](blocks/search_block.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `simple_gse_search.settings`, single key `cx` (Google Search ID; default `''`); schema type `text`, translatable (config translation registered).
- Settings form route `simple_gse_search.admin_settings` → `/admin/config/search/simple_gse_search`, class `SettingsForm` (`ConfigFormBase`), perm `administer gse search`.
- Results route `simple_gse_search.search_page` → `/search`, controller `SearchPage::displaySearchResults`, perm `access gse search page`.
- Block plugin id `simple_gse_search_block` (category "Search") renders `SearchForm` (form id `simple_gse_search_form`, field `s`, submit "go"); submit redirects to `/search?s=<query>`.
- Library `simple_gse_search/search` (`js/simple_gse_search.js`; deps `core/jquery`, `core/drupalSettings`) loads `https://cse.google.com/cse.js?cx=<cx>`; `cx` passed via drupalSettings `simple_gse_search.cx`.
- `/search` is core Search's default path; `hook_install` + `hook_requirements` warn when the core `search` module is enabled.
