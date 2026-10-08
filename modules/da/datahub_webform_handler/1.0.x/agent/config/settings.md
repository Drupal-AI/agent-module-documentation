<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object and the token/endpoint flow

## Install & enable

```bash
composer require drupal/webform      # required dependency (^6.0)
drush en datahub_webform_handler -y
```

Only Drupal dependency is **`webform`** (info.yml `dependencies: webform:webform`). No submodules,
no permissions, no Drush, no config schema.

## The settings form

- Class `WebformDataHubConfigForm` (`src/Form/WebformDataHubConfigForm.php`), a `ConfigFormBase`.
- Route **`datahub_webform_handler.config`** (`datahub_webform_handler.routing.yml`):
  - path `admin/config/services/webform_datahub-config`
  - requirement `_permission: 'access administration pages'`
  - `_admin_route: TRUE`
- Menu link `datahub_webform_handler.admin_config_language.config`
  (`datahub_webform_handler.links.menu.yml`), parent `system.admin_config_services`
  (*Configuration → Web services*).
- Form id `webform_datahub_config_form`. Editable config: **`webform_datahub.settings`**.
- (README/USAGE mention `/admin/config/system/webform_datahub-config`; the actual route path is
  `.../services/...` as defined in routing.yml.)

### Fields (`buildForm()`)

| Form key | Type | Stored config key | Notes |
|---|---|---|---|
| `username` | textfield (required) | `username` | Sent as an HTTP **`username` header** to the token endpoint. |
| `password_field` | textfield (required) | `password_field` | Sent as an HTTP **`password` header**. Masked to `type=password` client-side by `js/webform_datahub.js`. |
| `accessToken` | hidden | `accessToken` | Cached token from the last successful login (set during validation). |
| `endpoint_api` | textfield (required) | `endpoint_api` | Base URI of the Datahub API (e.g. `https://host/...`). |

## Config object `webform_datahub.settings`

Created/updated only when the form is saved (there is **no** `config/install` default and **no**
`config/schema`). Keys:

- `endpoint_api` — base URI. Consumers append paths:
  - `{endpoint_api}/api/secure/token` — login (GetAccessToken + form validation).
  - `{endpoint_api}/api/attendee/registration` — submission POST (DatahubIntegration).
- `username`, `password_field` — credentials, stored as-is.
- `accessToken` — last token obtained at save time.

Example (values illustrative):

```yaml
# webform_datahub.settings
endpoint_api: 'https://example-datahub.test'
username: 'apiuser'
password_field: 'REDACTED'
accessToken: ''
```

## Validation flow (`validateForm()`)

1. Builds `endpoint_api . "/api/secure/token"` and checks it against a URL regex; if it lacks
   `http://` / `https://` → error *"EndPoint API Key protocol is missing"*; if the regex fails →
   *"EndPoint API Key is incorrect"*.
2. Performs a **live login**: `\Drupal::httpClient()->post($token_url, ['headers' => ['Content-Type'
   => 'application/json', 'username' => $username, 'password' => $password_field]])`.
3. On success, reads `accessToken` from the JSON body and saves it into
   `webform_datahub.settings`; the response body is written to the log channel
   *"accessToken form response_body"*.
4. On any throwable, sets a *"Username or password is incorrect"* messenger error and marks the
   username/password fields invalid (save is blocked).

`submitForm()` then persists `endpoint_api`, `username`, `password_field`.

## Operational notes

- The token endpoint is authenticated by passing the credentials as **plain HTTP headers**
  (`username` / `password`), not a body — this is what the target Datahub expects.
- The call uses default Guzzle, so **TLS certificate verification is enabled** (no `verify => false`
  anywhere in the module).
- Because the endpoint and credentials come only from this admin form, an operator with the
  `access administration pages` permission controls the destination; nothing here is
  request-supplied.
