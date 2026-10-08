Language Cookie adds a "Cookie" language negotiation method that remembers a visitor's last language in a cookie and reuses it on later requests, with a pluggable condition system controlling when the cookie is (re)set.

---

The module registers a `LanguageNegotiationCookie` negotiation plugin (id `language-cookie`, default weight -5) that, during language detection, reads the configured cookie (`param`, default `language`) and returns its value as the langcode when it matches an enabled site language — triggering the page-cache kill switch so cached pages don't serve the wrong language. A response event subscriber (`LanguageCookieSubscriber`, priority 20) sets/refreshes the cookie: it determines the language by running the negotiation methods with higher priority than the cookie method for the configured `language_type` (default the interface language), then writes a cookie honouring the configured `time`, `path`, `domain`, `secure`, and `http_only` options (allowing `hook_language_cookie_alter()` to modify it). Whether the cookie is set is gated by a set of **condition plugins** (`@LanguageCookieCondition`, managed by `plugin.manager.language_cookie_condition`): shipped conditions skip setting it on blacklisted paths, non-index.php requests, XMLHttpRequests, invalid methods/paths, disallowed language access, certain PHP SAPIs, and server-address checks. Configuration lives in `language_cookie.negotiation` and is edited at `/admin/config/regional/language/detection/language_cookie` (the module's `configure` route is core's `language.negotiation` page); enable and order the "Cookie" method there. It depends on core `language` and `path_alias`, defines `hook_language_cookie_condition_info_alter()` and `hook_language_cookie_alter()`, and (per the README) supports the URL → Cookie → Language Selection Page → Default ordering, plus a "set on every page load" option for Varnish-style caches.

---

- Remember a visitor's chosen interface language across visits via a cookie.
- Fall back to a cookie-stored language when the URL contains no language prefix.
- Persist language selection made on a Language Selection Page for subsequent requests.
- Keep users on their last language without requiring a logged-in account.
- Set the language cookie based on the interface, content, or URL language type.
- Configure the cookie name, lifetime, path, and domain scope.
- Restrict the cookie to secure HTTPS connections (`secure` flag).
- Mark the cookie HttpOnly to block client-side script access (default on).
- Re-send the cookie on every page load to cooperate with Varnish/URL caching.
- Prevent the cookie from being set on specific blacklisted paths.
- Skip setting the cookie on AJAX/XMLHttpRequest responses.
- Skip the cookie on non-index.php (CLI/cron) requests via the IndexPhp condition.
- Avoid setting a language the current user has no access to (LanguageAccess condition).
- Implement a custom condition plugin to add site-specific rules for when to set the cookie.
- Alter the outgoing cookie (name/value) with `hook_language_cookie_alter()`.
- Modify or reprioritize condition plugins with `hook_language_cookie_condition_info_alter()`.
- Build a cookie-driven, JS-based language redirect on fully cached pages.
- Combine cookie negotiation with URL and user-preference negotiation in a chosen order.
- Ensure page cache isn't poisoned with the wrong language (kill switch on cookie hit).
- Migrate a Drupal 7 cookie-language setup (legacy config route redirects to the new form).
