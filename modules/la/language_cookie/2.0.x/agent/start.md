# Language Cookie — agent index

Adds a "Cookie" language negotiation method that remembers a visitor's language in a cookie, plus a
pluggable condition system deciding when to (re)set it. Depends on core `language` + `path_alias`.
Config object `language_cookie.negotiation`; `configure` route is core `language.negotiation`.

- **Settings keys, the negotiation method + response subscriber, how to enable/order the Cookie
  method, cache implications** → [configure/negotiation.md](configure/negotiation.md)
- **The `LanguageCookieCondition` plugin type: the shipped conditions and how to write one** →
  [plugins/conditions.md](plugins/conditions.md)
- **The two alter hooks (`hook_language_cookie_alter`, `hook_language_cookie_condition_info_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Negotiation plugin `LanguageNegotiationCookie` (id `language-cookie`, weight -5). Reads cookie
  `param` (default `language`); on a hit triggers the page-cache kill switch.
- `LanguageCookieSubscriber` (KernelEvents::RESPONSE, prio 20) sets the cookie using higher-priority
  negotiation for `language_type` (default interface), gated by all condition plugins passing.
- Uses core permission `administer languages` (no own permissions). Config schema present.
