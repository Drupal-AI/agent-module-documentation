<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Live Search - Person (livesearch_person) — agent index
**Webform integration that autofills contact/address fields from an external person-directory API.**

- **Version:** 1.1.x
- **Core:** ^8.8 || ^9 || ^10
- **Depends on:** Webform
- **Admin routes:** `livesearch.livesearch_config_form` and `.../test` (`administer livesearch`); per-webform `entity.webform.settings_livesearch_person` (`webform.update`)
- **Search route:** `livesearch.livesearch_person_controller_search_directory` → `/livesearch-person/search-directory`, permission `access content`
- **Service:** `livesearch_person.webapi` (`LiveSearchPersonService`), GET to `{livesearch_url}{search}` with `X-API-Key` header
- **Config:** `livesearch_person.livesearchconfig` (livesearch_url, livesearch_apikey, debug flag)

**Security:** admin config and per-webform settings are properly gated; the search proxy route is only gated by `access content` (effectively anonymous on default sites) and returns PII (names, addresses, birth dates) via the site's server-side API key. Tighten access if the directory is sensitive. Outbound call over configured HTTPS with default TLS verification.

See [configure/setup.md](configure/setup.md)
