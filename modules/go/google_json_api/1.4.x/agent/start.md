<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google JSON API (google_json_api) — agent index

**Core Search plugin backed by Google Programmable Search Engine JSON API.**

- **Version:** 1.4.x  | **Core:** ^8 || ^9 || ^10
- **Depends:** search, token.
- **Configure:** `/admin/config/search/google-json-api` (route `google_json_api.settings`, perm `administer google json api`); per-search-page config holds `cx` (engine id) + `apikey`.
- **Components:** Search plugin `GoogleJsonApiSearch`; pager decorator `GoogleJsonAPIPagerManager` (decorates `pager.manager`); Twig `HighlightSearchTerm`.

**Security:** requests use Drupal `http_client` (Guzzle) with **default TLS verification** (no verify=>false); endpoint URL is admin-configured (no user-controlled SSRF); API key stored in search-page config. Config route restricted. Sound.
