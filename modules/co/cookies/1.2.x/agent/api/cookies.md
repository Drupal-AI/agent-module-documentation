# Consent API & the knock-out (blocking scripts until consent)

## The knock-out pattern

A third-party script is neutralised by rewriting it so the browser will not execute it, then swapped back
to a live `<script>` once consent is given. The knocked-out type is a constant:

```php
Drupal\cookies\Constants\CookiesConstants::COOKIES_SCRIPT_KO_TYPE; // 'text/plain'
```

A bridge module decides *whether* to knock out on the current page with the PHP service:

```php
$doKo = \Drupal::service('cookies.knock_out')->doKnockOut(); // bool
```

`doKnockOut()` (class `Drupal\cookies\CookiesKnockOutService`, service id `cookies.knock_out`) returns TRUE
only when a COOKiES UI block is visible/accessible for the current user — so scripts run normally on pages
without the banner. The old `CookiesKnockOutService::getInstance()` singleton is deprecated in favour of the
`cookies.knock_out` service.

Typical bridge (see `cookies_ga.module`): in `hook_js_alter()` / `hook_page_attachments()`, when
`$doKo` is true, set on the third-party script `type => 'text/plain'`, an `id`, and
`data-cookieconsent => '<group>'` (e.g. `analytics`). The client-side handler then relives it on consent.

## Client-side JS event API (from the `cookiesjsr` library)

- **Grant/deny consent** — dispatch a `cookiesjsrSetService` CustomEvent:
  ```js
  // accept one service:
  document.dispatchEvent(new CustomEvent('cookiesjsrSetService', { detail: { services: { analytics: true } } }));
  // accept everything:
  document.dispatchEvent(new CustomEvent('cookiesjsrSetService', { detail: { all: true } }));
  ```
- **React to consent** — listen for `cookiesjsrUserConsent`; `event.detail.services` is a map of
  `serviceId => bool`. Every bridge (e.g. `cookies_ga.js`) listens for this and, when its group is true,
  replaces the `text/plain` script with a real one to execute it:
  ```js
  document.addEventListener('cookiesjsrUserConsent', function (event) {
    if (event.detail.services.analytics) { /* activate */ }
  });
  ```
- Anchor links act as controls: `#cookiesjsrAccept` (accept all), `#editCookieSettings` (re-open dialog,
  hash configurable via `open_settings_hash`).
- `cookiesjsrCallbackResponse` — the module's `cookies.lib.js`/behavior turns server callback responses
  into Drupal messages.

`jQuery.fn.cookiesOverlay(serviceId)` / `cookiesLegacyOverlay(serviceName)` (in `js/cookies.lib.js`) build
the placeholder overlay shown over a blocked element, with a "accept only this service" button and an
"accept all" link.

## Server-side consent hook

When the banner posts a decision to `/cookies/consent/callback.json` (`CallbackController::callback`), the
module invokes:

```php
/** Implements hook_cookies_user_consent(). */
function mymodule_cookies_user_consent($consent) {
  // $consent = map of serviceId => bool. Return a feedback array
  // ['status'|'warning'|'error' => 'message'] to surface a Drupal message.
}
```

Results are collected with `invokeAll('cookies_user_consent', [$consent])` and returned as JSON.

## Documentation token

`[cookies:docs]` renders the assembled service documentation; `cookies_docs_block` and the
`/cookies/documentation` page expose the same content.
