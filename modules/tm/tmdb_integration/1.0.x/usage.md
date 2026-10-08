<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TheMovieDB API Integration (on-disk module machine name: movie_db) connects a Drupal site to TheMovieDB (TMDb) REST API, providing configuration for the API base URL, bearer access token / API key, and services + blocks to search for and display movie data. It is admin-oriented: all routes are restricted to the administrator role.

---

The MovieDBIntegration service reads movie_db.settings (base_url, access_token or api_key) and calls the TMDb API over Guzzle using a Bearer Authorization header (default TLS verification is left on). It exposes a settings form (/admin/movie_db/settings), an admin menu page, a search controller (/tmdb/search_page/{category}/{query}), and Search/Trending movie blocks. All three routes require _role: administrator.

Use it to embed movie search or trending listings into an administrative area, or as a starting point for a movie-catalog integration. Because the search route interpolates the {category} and {query} path arguments and the base URL into the outbound request, keep the endpoints administrator-only (as shipped) — an admin-set base_url plus admin-only routes keep the outbound call under trusted control.

---

- Connect Drupal to TheMovieDB (TMDb) API.
- Store the TMDb base URL and access token.
- Authenticate API calls with a Bearer token.
- Optionally prefer an API key over the token.
- Search movies from an admin page.
- Display trending movies in a block.
- Provide a movie-search block.
- Configure integration at /admin/movie_db/settings.
- Restrict all routes to the administrator role.
- Call the API through the MovieDBIntegration service.
- Log API activity to a dedicated channel.
- Embed movie data into admin dashboards.
- Bootstrap a movie-catalog feature.
- Fetch category-scoped search results.
- Keep outbound requests under admin control.
- Reuse Guzzle with default TLS verification.
- Template rendered movie results.
- Extend for custom TMDb endpoints.
