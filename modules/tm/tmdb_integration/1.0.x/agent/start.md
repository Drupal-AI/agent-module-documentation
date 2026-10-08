<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TheMovieDB API Integration — agent index

Integrates with **TheMovieDB (TMDb) API** to search/display movie data. On-disk dir `tmdb_integration`; **real module machine name is `movie_db`** (`.info.yml`/files use `movie_db`). Version **1.0.4**. Core `^9.4 || ^10`.

`MovieDBIntegration` service (Guzzle, Bearer token from `movie_db.settings`, default TLS on). Routes: `/admin/movie_db`, `/admin/movie_db/settings`, `/tmdb/search_page/{category}/{query}` — **all `_role: administrator`**. Search/Trending blocks. Base URL is admin-set; admin-only routes keep the outbound call trusted (no anonymous SSRF surface).
