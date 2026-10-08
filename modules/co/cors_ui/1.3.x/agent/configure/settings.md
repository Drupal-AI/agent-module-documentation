# CORS UI — configuration

Route `cors_ui.config_form` → `/admin/config/services/cors` (form
`\Drupal\cors_ui\Form\CorsConfigurationForm`, permission **`administer cors`**, `restrict access: true`).
Saves to config object **`cors_ui.configuration`** (schema type `config_object`).

## Keys

| Key | Form element | Type | Meaning |
|---|---|---|---|
| `enabled` | checkbox | boolean | Master on/off for the core CORS middleware. |
| `allowedOrigins` | textarea (one per line) | sequence of strings | Origins allowed to make cross-origin requests. Use `*` alone to allow all. |
| `allowedMethods` | textarea | sequence | HTTP methods allowed cross-origin (or `*`). |
| `allowedHeaders` | textarea | sequence | Request headers allowed cross-origin (or `*`). |
| `exposedHeaders` | textarea | sequence | Response headers exposed to cross-origin JS (or `*`). |
| `supportsCredentials` | checkbox | boolean | Whether credentialed (cookie/auth) cross-origin requests are allowed. |
| `maxAge` | number | integer | `Access-Control-Max-Age` (preflight cache seconds). |

Textareas convert newline-separated input to arrays (and back) via a value callback.

## Origin validation

On save, `allowedOrigins` is validated unless it is exactly `['*']`:
- `*` may **not** be combined with other origins (error).
- Each origin must pass `UrlHelper::isValid(..., TRUE)` and contain **only** scheme + host + port —
  any path, query, or fragment is rejected (e.g. `https://example.com` ok; `https://example.com/app` invalid).

## How it reaches core's middleware

Core's CORS middleware reads the `cors.config` container parameter (usually hand-set in
`sites/*/services.yml`). CORS UI overrides it:
- `CorsUiServiceProvider::register()` runs `CorsUiCompilerPass`, which sets the container's
  `cors.config` parameter from the `cors_ui.configuration` config values.
- `cors_ui_install()` seeds `cors_ui.configuration` from the *existing* `cors.config` parameter
  (normalized via `CorsUiConfig::normalize()` so it matches the schema), so installing changes nothing.
- Since `cors.config` is baked into the compiled container, changes require a container rebuild:
  `ConfigSubscriber` (event subscriber, `needs_destruction`) sets a flag on
  `cors_ui.configuration` save and, on `destruct()`, invalidates the `http_response` cache tag and
  calls `DrupalKernel::rebuildContainer()`. The save form shows a message noting the container rebuild.

## Scripting with Drush

```bash
drush cset cors_ui.configuration enabled true -y
# origins/methods/headers are sequences — edit via the form, config import, or a small script.
drush cr   # ensure the container reflects the new parameter
```

No Drush commands are provided by the module.

## Security note (by design)

Setting a wildcard origin together with `supportsCredentials` is a permissive CORS posture, but the
form is gated by `administer cors` (`restrict access: true`) — a trusted administrator exposing core's
own CORS settings. There is no non-admin path to change these values, and the install-time default is
copied from the site's existing `services.yml` policy (it does not ship a permissive default).
