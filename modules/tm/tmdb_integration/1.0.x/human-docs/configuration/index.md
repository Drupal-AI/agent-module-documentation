# Configuration

TheMovieDB API Integration needs configuring before it can fetch anything — it has
to know which endpoint to call and how to authenticate. All of this lives on one
settings form.

## Open the settings form

1. Log in as an **administrator** (all of this module's pages are restricted to the
   administrator role).
2. Go to **`/admin/movie_db/settings`** (there is also an admin landing page at
   `/admin/movie_db`).

## Settings

The form stores its values in the `movie_db.settings` configuration object:

- **Base URL** — the base address of TheMovieDB REST API that the module calls.
  This is the endpoint every request is built on, so set it to TMDb's API base and
  keep it under trusted (administrator) control.
- **Access token** — the TMDb API bearer token. The module sends this as a
  `Bearer` authorization header on each request. Treat it as a secret.
- **API key** — as an alternative to the bearer token, the module can use a TMDb
  API key instead. Provide whichever credential your TMDb account gives you.

Requests are made over HTTP with standard TLS certificate verification left
enabled, so your credential and queries travel over a verified HTTPS connection to
TMDb.

## Save and use it

Save the form, then exercise the integration from the admin area: the search route
at `/tmdb/search_page/{category}/{query}` returns category-scoped results, and the
**Search** and **Trending** blocks can be placed to surface movie data. If
requests fail, re-check the base URL and that your access token or API key is valid.

Because the search route interpolates the path arguments and your configured base
URL into the outbound request, leave the module's routes restricted to the
administrator role (as they ship) — that keeps the outbound call under trusted
control.
