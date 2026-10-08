<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — cookie_samesite_support

**There is no settings form, no `configure` route and no config schema.** The module is entirely
code-driven: enabling it registers two service decorators and that is the whole of the
"configuration". `data.json.configure` is `null`; there is nothing for `drush config:export` to
capture and no admin page to visit.

## Enable / disable
- Enable: `ddev drush en cookie_samesite_support -y` (or via **Extend**), then rebuild so the
  decorators register: `ddev drush cr`.
- Verify the decorators are actually in front of core — this is the real "is it configured?" check:
  ```
  ddev drush php:eval "echo get_class(\Drupal::service('session_manager')), PHP_EOL, get_class(\Drupal::service('session_configuration'));"
  ```
  Both must report `Drupal\cookie_samesite_support\Session\…` classes. If they report the core
  `Drupal\Core\Session\SessionManager` / `SessionConfiguration`, another module is decorating those
  services after this one and it is inert.
- Disable: `ddev drush pmu cookie_samesite_support -y`. There is no config, schema or stored state to
  clean up; any `…-legacy` cookies already in browsers simply expire.

## Prerequisite: HTTPS + Secure session cookies
`SameSite=None` is only honoured by browsers when paired with `Secure`, and the legacy-restore path
hard-codes `'secure' => TRUE` (`src/Session/CookieSameSiteSupportSessionConfiguration.php:88`). The
site MUST be served over HTTPS end-to-end. Drupal's session-cookie parameters come from
`%session.storage.options%` (injected into the configuration decorator) and PHP's
`session_get_cookie_params()`; set them the usual way in `sites/default/services.yml`
(`parameters: session.storage.options:`) and `settings.php`. This module **adds no keys of its own —
it reuses Drupal's**. Over plain HTTP the browser discards the `SameSite=None` cookie and the module
cannot restore the session.

## What enabling changes (scope = whole site, all-or-nothing)
- Every session cookie the site emits gains `SameSite=None` (via
  `CookieSameSiteSupportSessionManager::save()`), plus a duplicate `<name>-legacy` cookie without the
  attribute for clients that reject `None`. There is **no allowlist and no per-route / per-cookie
  toggle** — it applies site-wide the moment the module is on. If only one flow needs a cross-site
  cookie, there is still no way to scope it narrower; that is the module's design.
- `SameSite=None` tells the browser to send the session cookie on cross-site requests. That is the
  intended purpose (embedding / gateway redirects) and it removes the browser-level `SameSite`
  restriction on the session cookie; Drupal's form tokens and `_csrf_token` route requirements are
  unaffected and remain the primary CSRF defence.

## Verify it is working (runtime)
Load a page over HTTPS and inspect the response `Set-Cookie` headers (browser devtools → Network, or
`curl -sI https://module-documentor.ddev.site/`). You should see the session cookie twice:
- `SESS<hash>=…; path=/; secure; SameSite=None`
- `SESS<hash>-legacy=…; path=/; secure` (no `SameSite`)

Seeing the pair confirms both decorators are live and the `Secure` prerequisite is satisfied.
