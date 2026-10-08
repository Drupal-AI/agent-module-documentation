<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install & configure Eulerian

## Install & enable

```bash
composer require drupal/eulerian
drush en eulerian -y
```

Only hard dependency is core **`path_alias`**. `composer.json` also requires `ext-mbstring`.
`hook_install` (`eulerian.install`) adds the `eulerian` Views display extender to
`views.settings:display_extenders` (removed again on uninstall). `hook_requirements` (runtime)
raises a **warning** while `track.domain` is empty, linking to the settings page.

## Settings form & route

- Route `eulerian.settings_form` → **`/admin/config/system/eulerian`**, permission
  **`administer eulerian`**. Form `\Drupal\eulerian\Form\SettingsForm` (extends `ConfigFormBase`,
  editable config `eulerian.settings`, form id `eulerian_settings`). Menu link under
  *Configuration → System*; a "Settings" local task tab.
- The **Domain** field is `#required` — enter your Eulerian website domain (e.g. the host that
  serves the Eulerian tag). This value is not a secret; it ends up in the client-side tag.

## Permissions (`eulerian.permissions.yml`)

- `administer eulerian` — configure the integration (gates the settings route).
- `use php for eulerian tracking visibility` — **`restrict access: true`** — only with this
  permission *and* the core `php` module enabled does the "PHP code" visibility option appear.

## Config object `eulerian.settings`

Schema `config/schema/eulerian.schema.yml`; install defaults `config/install/eulerian.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `track.domain` | `''` | Eulerian website domain (required to enable any tracking). |
| `track.userid` | `false` | Emit a hashed cross-device User ID for authenticated users. |
| `track.site_search` | `false` | Track internal search (needs core `search`). |
| `track.colorbox` | `false` | Track Colorbox modal content (needs `colorbox`; checkbox disabled otherwise). |
| `status_codes_disabled` | `{}` | HTTP status codes on which to suppress tracking (form offers `403`, `404`). |
| `clean_string` | `true` | Ask the JS to clean parameter strings to Eulerian's format before push. |
| `translation_set` | `false` | On translated nodes, report the originating node (needs `content_translation`). |
| `custom.parameters` | `[]` | List of `{name, value}` custom parameters (tokens allowed in both). |
| `visibility.request_path_mode` | `all` | `all` = every page except listed; `listed` = listed only; `php` = PHP snippet. |
| `visibility.request_path_pages` | `/admin`, `/admin/*`, `/batch`, `/node/add*`, `/node/*/*`, `/user/*/*` | Newline-separated paths (`*` wildcard, `<front>` supported). |

`EulerianInterface` defines the mode constants `TRACKING_REQUEST_MODE_ALL='all'`,
`_LISTED='listed'`, `_PHP='php'`.

## Visibility (`Services\EulerianVisibility::isEnabledOnCurrentPage()`)

- Mode `all` with empty page list → track everywhere.
- Mode `php` (only when the `php` module is enabled) → returns `php_eval($pages)`. Choosing this
  mode in the form requires the restricted `use php for eulerian tracking visibility` permission.
- Otherwise the current path **and its alias** (both lowercased) are matched against the page list
  with `PathMatcher::matchPath()`; `all` tracks when there is no match, `listed` tracks when there
  is a match. The result is statically cached per request.
- Path validation in the form (`validateFormVisibility`) requires each non-PHP line to start with
  `/` (or be `<front>`).

## Custom parameters & the token blocklist

- `buildFormCustomParameters()` renders an AJAX add/remove table of `{name, value}` slots
  (name `#maxlength` 100, value 255). With the `token` module enabled, values support node tokens
  and show a token tree.
- Values are validated by `SettingsForm::tokenElementValidate()` against `TOKEN_FORBIDDEN_LIST` —
  a blocklist of personally-identifying tokens (`:mail]`, `:uid]`, `:account-name]`, `user:name]`,
  `:ip-address]`, address/realname tokens, …). A forbidden token sets a form error, so PII cannot be
  configured into the datalayer through this form.
- At render time (`Hook\EulerianHooks::pageAttachments()`) each name/value is
  `\Drupal::token()->replace()`-d (node context when on a node page, `clear => TRUE`); empty
  name/value pairs are dropped.

## Site search

When core `search` is enabled, `track.site_search` is on, the route starts with `search.view`, and
a non-empty `keys` query parameter is present, `pageAttachments()` adds `isearchengine`
(the resolved page title), `isearchkey`, `isearchdata` (the query) and `isearchresults`
(pager total) to the datalayer. Views-based search uses the display extender instead
(see [../plugins/views_display_extender.md](../plugins/views_display_extender.md)).

## Operate

1. Enter the Domain and save. 2. Pick a visibility mode and page list. 3. Toggle User ID / search /
Colorbox / status-code suppression as needed. 4. Add custom parameters if wanted. 5. Verify the tag:
view page source and confirm `drupalSettings.eulerian` and the `eulerian/init` asset are present on
a tracked page (and absent on excluded paths and, if configured, on 403/404 pages).
