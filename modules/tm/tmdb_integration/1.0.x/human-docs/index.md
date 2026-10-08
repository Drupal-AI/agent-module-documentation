# TheMovieDB API Integration — manual setup guide

**TheMovieDB API Integration** (machine name `movie_db`) connects your Drupal site
to [TheMovieDB](https://www.themoviedb.org/) (TMDb) REST API so you can search for
and display movie data from within Drupal. It provides the plumbing — a settings
form, a service that talks to the API, a search page, and two blocks — for pulling
movie information into your site.

A quick but important note on naming: the project and its download directory are
called `tmdb_integration`, but the **actual module machine name is `movie_db`**
(that is the name in the `.info.yml` file and what you enable with Drush). The
Composer package is `drupal/tmdb_integration`. Keep both names in mind — install
by the Composer name, enable by the machine name.

The module is admin-oriented by design. Everything it exposes — the settings form,
the admin landing page, and the search route (`/tmdb/search_page/{category}/{query}`) —
is restricted to the administrator role. It ships a **Search** block and a
**Trending** block for surfacing results. Under the hood a service
(`MovieDBIntegration`) reads your configured base URL and access token and calls
TMDb over HTTP with a Bearer authorization header (standard TLS verification is
left on). Because the search route builds the outbound request from the URL path
and your admin-set base URL, keeping the routes administrator-only — as shipped —
keeps that outbound call under trusted control; do not loosen those access
restrictions.

This is an unofficial integration. It **needs configuration before it does
anything**: you must enter a TMDb base URL and an access token (or API key) on its
settings form. It has no other module dependencies.

This guide is written for a **human** setting the module up by hand. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (remember: enable `movie_db`, not `tmdb_integration`).
2. [Configuration](configuration/index.md) — enter your TMDb base URL and access
   token on the settings form.

## Where it lives in the admin menu

The settings form is at **`/admin/movie_db/settings`** (config object
`movie_db.settings`), with an admin landing page at `/admin/movie_db`. Both, and
the search route, require the administrator role.
