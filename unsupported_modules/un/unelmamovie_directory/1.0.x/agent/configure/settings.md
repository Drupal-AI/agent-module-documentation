<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — UnelmaMovie Directory

## Settings form
Route `unelmamovie_directory.api_config_page` at `/admin/config/unelmamovie-api`
(`Form\UnelmaMovieAPI`). Two required text fields:

- **API Base URL** → stored as `api_base_url`
- **API Key** → stored as `api_key`

Values are saved to Drupal **State** under the key `movie_api_config_page:values`
(constant `UnelmaMovieAPI::UNELMAMOVIE_API_CONFIG_PAGE`). There is no config schema
and no Config entity — this is runtime State, so it is not exportable.

## How the listing works
`MovieListing::view()` calls the `unelmamovie_directory.api_connector` service.
`UnelmaMovieAPIConnector::browseMovies()` reads the State values, builds a Guzzle
client with header `Authorization: Bearer <api_key>`, and GETs
`<api_base_url>/titles?<fixed query>` (perPage=11, order=popularity:desc,
genre=action,comedy, released=2019,2021, score=7,10, language=en, …). The decoded
`pagination->data` array is handed to the `unelmamovie-listing` template.

## Hardening (important)
Both routes use `_permission: 'access content'`, which anonymous users hold by
default. Change the requirements in `unelmamovie_directory.routing.yml` to an
admin permission (e.g. `administer site configuration`) for the config form, and
move the API key to a Key entity rather than plaintext State.
