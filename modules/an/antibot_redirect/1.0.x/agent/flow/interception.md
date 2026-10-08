<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request interception & the verify page

Two source files implement the whole flow:
`src/EventSubscriber/BotBlockSubscriber.php` and `src/Form/AntibotCheckForm.php`.

## BotBlockSubscriber::onRequest()

Service `antibot_redirect.kernel_request_subscriber`, subscribed to `KernelEvents::REQUEST` at
priority **-10** (`getSubscribedEvents()`). Constructor args: `@request_stack`, `@config.factory`,
`@page_cache_kill_switch`.

Logic, in order:

1. Return immediately if `!$event->isMainRequest()` (sub-requests are ignored).
2. Read `$path = $request->getPathInfo()`.
3. **Exclusions** — return (no gating) when `$path` is `/verify-human` or `str_starts_with($path, ...)`
   any of `/admin`, `/core/`, `/sites/default/files/`.
4. Compute `$botURL = $referer ? strstr($referer, $base_url) : ''` from the request `Referer` header
   and the global `$base_url`.
5. Call `$this->killSwitch->trigger()` (disables the page cache for this response).
6. If session flag `verified_human` is TRUE → return (visitor already passed).
7. Load `antibot_redirect.settings:protected_paths`, split on newlines, `trim`, drop empties.
8. For each protected path, build a case-insensitive full-path regex:
   `'#^' . str_replace('\*', '.*', preg_quote($protected_path, '#')) . '$#i'` — so `*` becomes `.*`
   (wildcard) and everything else is literal. `preg_match` against `$path`.
9. On the first match: if the `Referer` is empty **or** does not contain the site's own `$base_url`
   (`$botURL == ""`), trigger the kill switch again and set the response to
   `new RedirectResponse('/verify-human?destination=' . urlencode($current_uri))`, where
   `$current_uri = $request->getRequestUri()`. `break` after the first matching path either way.

Net effect: a request to a protected path that arrives **without a same-site Referer** is bounced to
the verify page; a request that carries a Referer pointing back at this site is served directly.

## AntibotCheckForm (`/verify-human`)

- `getFormId()` → `antibot_check_form`; route `antibot_redirect.form`, `_permission: access content`.
- `buildForm()`: if `antibot_redirect.settings:verify_page_description.value` is non-empty, renders it
  as a `#type => processed_text` element using the stored text `format` (default `basic_html`), then
  adds `captcha` (`#type => captcha`, `#captcha_type => 'recaptcha/reCAPTCHA'`) and a submit button
  labelled "Verify & Continue".
- `getPageTitle()` (the route `_title_callback`): returns `verify_page_title` or `''` if empty.
- `submitForm()`: sets session `verified_human = TRUE`, reads `destination` from the query
  (default `/`), and redirects via `Url::fromUserInput($destination)`.

## Operational caveats (functional, not exploits)

- **The gate is a light deterrent, not access control.** It keys off the `Referer` request header
  (client-controlled) and a per-session flag; verification is per browser session and never expires
  within the session. Do not rely on it to protect sensitive or authenticated content.
- **Page cache impact.** `killSwitch->trigger()` runs for every non-excluded main request that
  reaches step 5 (i.e. before the verified-session check and before any path match). On sites with a
  large anonymous audience this disables the anonymous page cache broadly — weigh this before
  enabling on a busy site.
- **Exclusions are prefix-based**, so all of `/admin*`, `/core/*`, and `/sites/default/files/*` are
  always served without gating.
- **Redirect target** is `Url::fromUserInput($destination)`; Drupal normalises this to an internal
  path (a protocol-relative or external value is stripped/rejected), so the destination resolves
  on-site.
