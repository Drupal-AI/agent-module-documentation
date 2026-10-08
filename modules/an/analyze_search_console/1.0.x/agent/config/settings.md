<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, OAuth connect flow, routes & permission

## Install & enable

```bash
composer require drupal/analyze_search_console
drush en analyze_search_console -y
# If you see "Class Google\Client not found":
composer require google/apiclient
```

Hard deps: `analyze` (>=1.1.0) and `key`. `google/apiclient` (`^2.19`) is a Composer requirement
but is not pulled in by every install path. `hook_install()` (`analyze_search_console.install`)
adds a warning message linking to the settings form; `hook_uninstall()` deletes the
`analyze_search_console.settings` config object and the `analyze_search_console.access_token`
state entry.

## Routes & access (`analyze_search_console.routing.yml`)

| Route | Path | Requirement |
|---|---|---|
| `analyze_search_console.settings` | `/admin/config/analyze/search-console` | `_permission: administer analyze settings` (form) |
| `analyze_search_console.oauth_callback` | `/admin/config/analyze/search-console/oauth-callback` | `_permission: administer analyze settings` |
| `analyze_search_console.disconnect` | `/admin/config/analyze/search-console/disconnect` | `administer analyze settings` + `_csrf_token: TRUE` |
| `analyze_search_console.report` | `/admin/reports/search-console` | `_permission: access search console reports` |

`administer analyze settings` is provided by the parent **analyze** module. The only permission
this module defines (`analyze_search_console.permissions.yml`) is **`access search console
reports`** (title "Access Search Console reports"). Menu links: settings under `ai.admin_settings`,
report under `system.admin_reports` (`*.links.menu.yml`); local tasks Settings + Report
(`*.links.task.yml`).

## Config object `analyze_search_console.settings`

Install defaults (`config/install/analyze_search_console.settings.yml`) and schema
(`config/schema/analyze_search_console.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `client_id` | string | `''` | **Key entity ID** holding the Google OAuth client ID (not the value). |
| `client_secret` | string | `''` | **Key entity ID** holding the OAuth client secret. |
| `property_url` | string | `''` | Selected Search Console property (`https://example.com/` or `sc-domain:example.com`). |
| `date_range` | integer | `28` | Default window in days (7/14/28/90). |
| `search_type` | string | `web` | Default search type (web/image/video/news). |
| `base_url_override` | string | *(unset)* | Production URL for dev/staging path mapping (e.g. `https://example.com`). |
| `cache_ttl` | integer | `21600` | Result cache lifetime in seconds (1h/6h/12h/24h in the UI). |

`client_id`/`client_secret` store **Key module entity IDs**; `SearchConsoleSettingsForm` uses
`#type => key_select`, and `SearchConsoleClient::getKeyValue()` /
`OAuthCallbackController::resolveKey()` resolve them via `key.repository` at call time. The OAuth
**token itself is never in config** — it is kept in state key `analyze_search_console.access_token`.

## OAuth connect flow (`Form\SearchConsoleSettingsForm`, `Controller\OAuthCallbackController`)

1. Admin creates a Google Cloud project, enables the Search Console API, and creates a **Web
   application** OAuth client whose authorized redirect URI is exactly the site's
   `…/search-console/oauth-callback` (the form prints the exact URL via `getCallbackUrl()`).
2. Admin stores the client ID/secret as two Key entities, selects them on the settings form, and
   saves (`submitForm()` writes the config keys above).
3. `buildForm()` shows a **Connect to Google Search Console** link when `hasCredentials()` is true.
   `buildAuthUrl()` builds a `Google\Client` with scope
   `https://www.googleapis.com/auth/webmasters.readonly`, `setAccessType('offline')`,
   `setPrompt('consent')`, `setIncludeGrantedScopes(TRUE)`, and returns `createAuthUrl()`.
4. Google redirects back to `oauth_callback`; `OAuthCallbackController::callback()` reads `code`
   (or `error`), exchanges it with `fetchAccessTokenWithAuthCode($code)`, and stores the token
   array in state `analyze_search_console.access_token`.
5. Once authorized, the form lists properties (`listAvailableProperties()`) in a `property_url`
   select and shows the connected account email (`getAccountEmail()` decodes the id_token payload).
6. **Disconnect** link → `disconnect()` route (CSRF-protected): revokes the token via
   `Google\Client::revokeToken()` and deletes the state entry.

## "Configured" definition

`SearchConsoleClient::isConfigured()` is true only when client_id key, client_secret key,
`property_url`, **and** a stored token are all present. The Analyze plugin and report controller
short-circuit to a "not configured" message otherwise; the Drush commands error out. Data is
requested with `dataState: all` (fresh/unfinalized) and cached under cache tag
`analyze_search_console` for `cache_ttl` seconds.
