<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translation delivery (proxy, ActiveJS, custom switchers)

How translated content reaches the visitor: the server-side proxy, the browser-side ActiveJS script injection, and the server-side rewriting of custom language-switcher links.

## ProxyRequestSubscriber (`src/EventSubscriber/ProxyRequestSubscriber.php`)

Service `motaword.proxy_request_subscriber`, subscribes to `KernelEvents::REQUEST` at priority **100** (after authentication 300, before RouterListener 32) so it can intercept any URL without a registered route. Fails open on every error path — if anything goes wrong the subscriber returns and Drupal serves the original page.

`onRequest()` guards, in order:
1. Main request only (`MainRequestTrait`).
2. **GET only** — never proxy form submissions / writes.
3. **Loop guard** — if the request carries an `X-MotaWord-Token` header it originated from Serve fetching the source page, so pass through.
4. Reads token + `is_active_serve_enabled`, calls `MetadataRefresher::ensureLoaded()`, then evaluates via `UrlAllowList::evaluate()` with the project's `targetLanguages`, the parsed blacklist, `EXCLUDED_PATH_PREFIXES` (`/admin`, `/user/login`, `/jsonapi`, `/rest/`, `/core/`, `/.well-known/`, …), and whether the user is authenticated.

Verdict handling: `passthrough` → return; `redirect` → `LocalRedirectResponse` off-locale (query string preserved, tagged with the settings + metadata cache tags); `proxy` → `proxy()`.

`proxy()`:
- If the widget is not live, only `administer motaword` users get the Serve render (others pass through).
- Builds the full source URL (scheme+host+path+query), forwards **only** the `User-Agent` header to Serve (cookies stripped; the visitor's `Authorization` header is deliberately not forwarded — Serve authenticates with the token, not `Authorization`).
- Calls `ServeClient::fetchTranslated()`. `null` → fail open. `3xx` with `Location` → `TrustedRedirectResponse` (Serve's Location is often off-host; wrapped so Drupal's external-redirect guard allows it) with `max-age 0` + page-cache kill switch. Otherwise replays the body + status with `buildResponseHeaders()`.
- `buildResponseHeaders()` always sets `Cache-Control: private, no-store, max-age=0` (so Drupal page_cache doesn't double-cache Serve's CDN cache), forwards `Content-Type`, and renames Serve's cache-debug headers to `x-motaword-*`. `RESPONSE_HEADERS_TO_NOT_FORWARD` (connection, content-encoding/length, transfer-encoding, set-cookie, keep-alive, cache-control) are stripped.

## UrlAllowList (`src/UrlAllowList.php`, service `motaword.url_allow_list`)

Pure, testable evaluator — no dependencies. `evaluate($path, $targetLocales, $blacklistPaths, $proxyAvailable, $excludedPathPrefixes, $isAuthenticated)` returns `['action' => 'passthrough'|'proxy'|'redirect', 'to'?]`. It matches a leading locale prefix against the project's target locales (regex built from `preg_quote`d codes). It redirects off-locale (instead of proxying) when the proxy is unavailable, the user is authenticated (so Drupal renders personalized chrome), the locale-stripped path hits an excluded prefix, or it matches the blacklist (slash-insensitive). Otherwise it proxies. Empty target-locale list → everything passes through.

## ActiveScriptBuilder (`src/ActiveScriptBuilder.php`, service `motaword.active_script_builder`)

Builds the `html_head` attachments returned by `getAttachments()`, called from `motaword_page_attachments()`. Constructor: `config.factory`, `current_user`, `router.admin_context`, `metadata_store`.

- Admin routes → returns empty (never translate the admin UI).
- Helper hide-locale CSS (`buildHideLocaleCss()` → `.hide-locale-XX` rules per source/target locale) is emitted whenever metadata exists.
- The script tag injects only when metadata exists AND `shouldInjectScript()` passes: `is_insert_active_js` on → inject for everyone; off → inject only for `administer motaword` users when `is_insert_for_admin_when_disabled` is on.
- Script src is `<publicServeHost>/js/<projectId>-<widgetId>.js` with attributes `data-token` (the Active token), `crossorigin`, `async`, optional `data-url-mode` (auto-derived override), optional `data-render-widget="false"` (custom switcher), and `referrerpolicy="unsafe-url"`. Preconnect/preload hints and a `<meta name="google" content="notranslate">` are added; admins get extra `motaword:*` debug meta tags. The browser-facing host comes from `serve_host` (falls back to `https://serve.motaword.com`) — distinct from ServeClient's internal host.

## LanguageMenuManipulator (`src/LanguageMenuManipulator.php`, service `motaword.language_menu_manipulator`)

Called from `motaword_preprocess_menu()`. Rewrites menu-item hrefs tagged with switcher CSS classes so custom pickers work server-side:

- `nolocalize` (or `translate="nolocalize"`) — leave the href alone; wins over other classes.
- `localize-page-as-<locale>` — set href to the current page localized to `<locale>`.
- `localize-as-<locale>` — localize the link's own href.
- `switch-current-url-<locale>` — legacy alias of `localize-page-as-<locale>`.

Two-pass collect-batch-apply: pass 1 gathers the source URLs, then a single `ServeClient::prepareCustomerUrls()` call resolves them, pass 2 rewrites in place and stamps `translate="nolocalize"` so ActiveJS doesn't re-touch them. Locale codes are validated against `LOCALE_RE`. On any Serve failure it logs and leaves URLs unchanged (only sets the attributes). `hook_preprocess_menu` adds `url.path` + `user.permissions` cache contexts and the settings + metadata cache tags.

## Page attachments & cache safety (`motaword.module`)

`motaword_page_attachments()` adds the builder's head tags, plus the `user.permissions` cache context (so an anonymous page-cache entry never leaks the admin-preview branch) and the `config:motaword.settings` + `motaword_metadata` cache tags. `motaword_preprocess_toolbar()` sets `translate="no"` on the admin toolbar so no translation layer mangles it.
