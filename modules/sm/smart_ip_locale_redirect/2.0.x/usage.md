<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart IP Locale Redirect maps a visitor's IP-derived country to a site language and issues a 302 redirect to the matching language-prefixed URL, storing the decision in a `smart_ip_hl` cookie.
---
A KernelEvents::REQUEST subscriber (priority 256, before routing) runs `RedirectChecker::canRedirect()` to decide whether the current request is eligible: only GET/HEAD requests on the front controller are redirected, admin routes, node edit forms, maintenance mode, file paths under `/sites/default/files/`, and configured excluded user-agents are skipped, and the visitor's role must be one of Smart IP's "roles to geolocate". When eligible it looks up the country via `SmartIp::query($client_ip)`, resolves the mapped langcode from module config, and rebuilds the destination URL through the alias manager.

The destination host is always the site's own host (`$request->getSchemeAndHttpHost() . $request->getBaseUrl()`) — the langcode/path is appended to that fixed origin — so the redirect target is not taken from a request parameter. An `update_hl` query parameter and the `smart_ip_hl` cookie can override the chosen language; the cookie is set HttpOnly. Page cache is killed for pages that reach the negotiation logic, so the redirect only fires until the visitor lands on the correct prefix. Configuration lives at `/admin/config/search/smart_ip_locale_redirect` behind the "access smart IP locale redirect settings" permission.

Typical setup: enable Smart IP and configure geolocation, define the country → langcode mappings on the settings form, set cookie duration/path/domain, and optionally list excluded user-agents (e.g. crawlers).
---
- Redirect visitors to a language based on their country of origin.
- Map each ISO country code to a specific site langcode.
- Remember a visitor's language choice in the `smart_ip_hl` cookie.
- Let visitors override the detected language via an `update_hl` parameter.
- Configure the cookie duration, path, and domain.
- Exclude specific user-agents (crawlers, monitors) from redirection.
- Restrict geolocation to selected roles via Smart IP settings.
- Skip redirection on admin routes and node edit forms automatically.
- Preserve query strings across the language redirect.
- Avoid redirect loops when the current language already matches.
- Keep file requests under `/sites/default/files/` un-redirected.
- Disable page cache only for pages performing IP negotiation.
- Translate a path alias into the target language before redirecting.
- Delete a country → language mapping from the admin UI.
- Serve a 503 when a redirect loop is detected.
- Combine with the Redirect module's loop protection.
- Set a per-country default landing language for a multilingual site.
- Honour an existing language cookie instead of re-querying geolocation.
- Grant editors access to the settings overview via a dedicated permission.
- Integrate IP-based language negotiation with path_alias and locale.