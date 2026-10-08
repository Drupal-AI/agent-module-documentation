# Configure Language Cookie negotiation

## Enable & order the method

The `configure` route is core's language negotiation page. The module's own settings form is at
`/admin/config/regional/language/detection/language_cookie`
(`Drupal\language_cookie\Form\NegotiationLanguageCookieForm`, route
`language_cookie.negotiation_cookie`, permission `administer languages`). A legacy D7 path
`/admin/config/regional/language/configure/language_cookie` 302-redirects to it.

Steps: go to *Configuration → Regional and language → Languages → Detection and selection*, enable the
**Cookie** detection method for the Interface language, and order it. Recommended (README):
**URL → Cookie → Language Selection Page → Default**. The plugin's default weight is `-5` (below
Language Selection Page at -4, above URL at -8).

## Settings (`language_cookie.negotiation`)

Defaults from `config/install/language_cookie.negotiation.yml`; schema in
`config/schema/language_cookie.schema.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `param` | string | `language` | Cookie name read/written. |
| `time` | int | `31536000` | Cookie lifetime in seconds from now (1 year). |
| `path` | string | `/` | Cookie path scope. |
| `domain` | string | `''` | Cookie domain scope (empty = current host). |
| `secure` | bool | `false` | Only send over HTTPS. Set TRUE at install if the install request was secure. |
| `http_only` | bool | `true` | Block client-side script access to the cookie. |
| `set_on_every_pageload` | bool | `false` | Re-send the cookie on every response (useful behind Varnish). |
| `language_type` | string | `language_interface` | Which language type drives the cookie value (interface/content/URL). Install sets it to interface. |
| `blacklisted_paths` | sequence | `[]` | Paths where the cookie is not set (used by the Blacklisted paths condition). |

The admin form exposes `param`, `time`, `path`, `domain`, `secure`, `http_only`,
`set_on_every_pageload`, plus each condition plugin's own sub-form; on submit it redirects back to
`language.negotiation`.

## How detection works (`LanguageNegotiationCookie::getLangcode()`)

Source: `src/Plugin/LanguageNegotiation/LanguageNegotiationCookie.php`. If the request has cookie
`param` and its value is an enabled site langcode, returns that langcode **and calls
`page_cache_kill_switch->trigger()`** — disabling the internal page cache for that request so a cached
page isn't served in the wrong language (see the module's `@todo` referencing core issue 2430335).

## How the cookie is set (`LanguageCookieSubscriber::setLanguageCookie()`)

Source: `src/EventSubscriber/LanguageCookieSubscriber.php`, subscribed to `KernelEvents::RESPONSE`
(priority 20).

1. `getLanguage()` picks the language by running all negotiation methods for `language_type` that
   have **higher priority than the cookie method** (skipping `language-selected` and the cookie method
   itself); falls back to the default language. Returns the site default immediately if the site is
   not multilingual.
2. Every condition plugin (see [../plugins/conditions.md](../plugins/conditions.md)) is instantiated
   with the config and executed; if any returns FALSE, no cookie is set.
3. The cookie is (re)written only when it's missing, differs from the resolved language, or
   `set_on_every_pageload` is on — using `time`, `path`, `domain`, `secure`, `http_only`. Other
   modules may adjust it via `hook_language_cookie_alter()` before it's attached.

## Uninstall behaviour

`hook_uninstall()` clears the `language-cookie` method from each language type's enabled negotiation
in `language.types`.
