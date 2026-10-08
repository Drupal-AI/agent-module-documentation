<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UnelmaMovie Directory pulls a movie list from the external UnelmaMovie REST API and displays it at `/unelmamovie`.

The module stores two values in Drupal State — an API base URL and a bearer API key — via a small settings form. A connector service (`unelmamovie_directory.api_connector`, class `UnelmaMovieAPIConnector`) builds a Guzzle client that sends `Authorization: Bearer <key>` and requests `<base_url>/titles` with a fixed query (perPage, genre, released, score, etc.), decodes the JSON, and returns `pagination->data`. The `MovieListing` controller passes that array to the `unelmamovie-listing` Twig theme hook.

Operationally there is very little to configure: set the base URL and key on the settings form, then view the listing. Security note: BOTH routes (`/admin/config/unelmamovie-api` and `/unelmamovie`) are gated only by the `access content` permission, which is granted to anonymous users by default — so the "admin" settings form is effectively public. The form pre-fills and therefore discloses the stored API key, and its submit handler writes attacker-supplied values straight into State, meaning anonymous users can both read the key and repoint the base URL (which is then fetched server-side). Treat this module as unsafe on a public site without tightening the route permissions.
---
Fetches and shows a remote movie catalogue on a Drupal page.
---
- Enable the module and its connector service.
- Set the UnelmaMovie API base URL on the settings form.
- Set the UnelmaMovie API bearer key on the settings form.
- Visit `/unelmamovie` to render the movie listing.
- Read movie data returned by the `/titles` endpoint.
- Theme the listing by overriding the `unelmamovie-listing` template.
- Adjust the hard-coded query (genre, score, runtime) by editing the connector.
- Inspect `UnelmaMovieAPIConnector::browseMovies()` for the request shape.
- Retrieve the stored config from State key `movie_api_config_page:values`.
- Show a curated action/comedy movie list on a public page.
- Integrate a third-party movie API without writing a custom module.
- Debug API connectivity via the messenger error output.
- Restrict the `access content`-gated routes to an admin permission (hardening).
- Move the API key out of State into a Key entity (hardening).
- Point the connector at a staging API base URL.
- Wrap the listing in a block or view via the theme output.
- Confirm the bearer token is sent on outbound requests.
- Rotate the API key by re-saving the settings form.
- Audit who can reach `/admin/config/unelmamovie-api`.
- Localize the listing markup through the Twig template.
