<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UnelmaMovie Directory (unelmamovie_directory) — agent index

**Fetches a movie catalogue from the UnelmaMovie REST API and renders it at `/unelmamovie`.**

- **Version:** 1.0.x (project `unelmamovie`, release 1.0.2)
- **Core:** ^9 || ^10 || ^11 || ^12
- **Routes:** `unelmamovie_directory.api_config_page` (`/admin/config/unelmamovie-api`, settings form), `unelmamovie_directory.listing` (`/unelmamovie`, controller `MovieListing::view`)
- **Service:** `unelmamovie_directory.api_connector` → `UnelmaMovieAPIConnector` (Guzzle, bearer auth, calls `<base_url>/titles`)
- **Config store:** Drupal State key `movie_api_config_page:values` (api_base_url, api_key)
- **Theme:** `unelmamovie-listing` (`content`, `movies`)

**Security:** BOTH routes are gated only by `_permission: 'access content'` (effectively anonymous). The settings form discloses the stored API key and lets anonymous users overwrite the base URL/key in State; the base URL is then fetched server-side (SSRF-capable). Not safe on a public site without restricting the route permissions.

See [configure/settings.md](configure/settings.md)
