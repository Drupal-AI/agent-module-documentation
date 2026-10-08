<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, route & the vary-header logic

## Install & enable

```bash
composer require drupal/acquia_cookie_vary
drush en acquia_cookie_vary -y
```

No dependencies (no other Drupal modules, no composer libraries), no submodules. Intended for sites
on the **Acquia Cloud** platform whose Varnish varies on `X-Acquia-Cookie-*` request headers.

## The settings form & route

- Route id **`acquia_cookie_vary.settings`**, path `/admin/config/services/acquia-cookie-vary`,
  `_form: \Drupal\acquia_cookie_vary\Form\SettingsForm`, requirement
  `_permission: 'administer site configuration'` (`acquia_cookie_vary.routing.yml`). Admin menu link
  under *Configuration → Web services* (`acquia_cookie_vary.links.menu.yml`, weight `-10`).
- `SettingsForm` (`src/Form/SettingsForm.php`) is a `ConfigFormBase` (POST + CSRF token),
  `getFormId() = 'acquia_cookie_vary_settings'`, editing config `acquia_cookie_vary.settings` via
  `ConfigTarget` bindings.

## Config object `acquia_cookie_vary.settings`

Defaults (`config/install/acquia_cookie_vary.settings.yml`):

```yaml
custom_cookie: ''
debug: false
```

Schema (`config/schema/acquia_cookie_vary.schema.yml`), `type: config_object`:

| Key | Type | Meaning |
|---|---|---|
| `custom_cookie` | `string` | Name of the one site-defined Acquia platform cookie to vary on. Validated by a `Regex` constraint `/^[^=;,"\\\n\r ]+$/` — rejects `=`, `;`, `,`, `"`, backslash, whitespace and CR/LF, i.e. only a valid cookie name. |
| `debug` | `boolean` | When true, reflect cookie values into `X-Acquia-Cookie-*` response headers for debugging. |

Set via Drush:

```bash
drush cset acquia_cookie_vary.settings custom_cookie geo -y
drush cset acquia_cookie_vary.settings debug 0 -y
drush cr
```

## How the vary headers are added

`ResponseSubscriber::onKernelResponse()` (`KernelEvents::RESPONSE`, priority **1000**):

1. Runs only if `$event->getResponse()` is a `CacheableResponseInterface` (otherwise no-op).
2. Loads `acquia_cookie_vary.settings` and the response's cache contexts
   (`getCacheableMetadata()->getCacheContexts()`).
3. For each entry in the class constant `PLATFORM_COOKIES`
   (`acquia_a → X-Acquia-Cookie-A`, `acquia_b → X-Acquia-Cookie-B`, `acquia_c → X-Acquia-Cookie-C`):
   if the context string `cookies:<name>` is present, calls `$response->setVary('<header>', FALSE)`.
   The second arg `FALSE` means **append** to the existing `Vary` header, not replace it.
4. If the configured `custom_cookie`'s context `cookies:<custom_cookie>` is present, appends **two**
   vary values: `X-Acquia-Cookie-Key` and `X-Acquia-Cookie-Value`.
5. If `debug` is true, for each matched cookie it also sets a response header carrying the current
   request's cookie value — `X-Acquia-Cookie-A/B/C: <request cookie value>`, and for the custom
   cookie `X-Acquia-Cookie-Key: <cookie name>` + `X-Acquia-Cookie-Value: <request cookie value>`.

Key point: the module **only mirrors cache contexts the page already declares**. To actually vary a
page, something must add the `cookies:<name>` cache context to that page's render metadata (e.g. a
block/controller calling `$build['#cache']['contexts'][] = 'cookies:acquia_a';`). Without that
context the module adds nothing.

## Operating notes

- Turn `debug` **off** in production; it exists only to confirm the plumbing and adds extra response
  headers reflecting the requester's own cookie values.
- Each varied cookie multiplies Varnish cache objects; watch the Acquia "LRU Nuked" rate.
- Behind an additional CDN (e.g. Cloudflare): enterprise → use Cache Keys on the individual cookies;
  non-enterprise → add a cache-bypass rule on the affected paths.
- Only vary by cookies that safely partition **public** content. Never add a `cookies:<session>` /
  auth-cookie context to a cacheable page — that is an operator concern, not something this module
  does on its own.
