<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Request Data Conditions adds four Drupal condition plugins that test the current request's cookies, HTTP headers, URL query parameters and session values, so blocks, layout sections and Context reactions can be shown or hidden based on that request data.

---

The module contributes four plugins to Drupal's condition system (`plugin.manager.condition`): **Cookie values** (`cookie_values`), **HTTP headers** (`http_headers`), **URL query parameters** (`url_query_parameters`) and **Session values** (`session_values`). Each reads a key-value bag from the current `Request` — respectively `cookies->all()`, `headers->all()`, `query->all()` and the session's `all()` — and evaluates a list of rules the admin configures. Every rule has three fields: a **Name** (the cookie/header/param/session key to look up), an **Operator**, and a **Value**. Nine operators are available: *must equal*, *must not equal*, *must be set*, *must be set and have any value*, *must be set and have no value*, *must not be set*, *matches regular expression*, *must contain* and *must not contain*. A **Require all** checkbox (default on) switches between AND (every rule must pass) and OR (any one rule passes) semantics across the rules of a single plugin instance. Because these are ordinary condition plugins they work anywhere Drupal consumes conditions — core block visibility, Layout Builder section visibility, the [Context](https://www.drupal.org/project/context) module's condition reactions, Page Manager, or your own code calling the condition manager. Each plugin declares the matching cache context (`cookies:NAME`, `headers:NAME`, `url.query_args:NAME`, or `session`) so render caching varies correctly. The module has no routes, no permissions, no settings page and no dependencies; you configure it entirely from the host form (block/section/context) where you add the condition. Note that these are **visibility** conditions, not access control: cookies, headers and query parameters are fully client-controlled, so never use them to protect sensitive content.

---

- Show a block only when a specific cookie is present.
- Hide a block when a cookie has a particular value.
- Reveal a promo block only when the URL carries `?campaign=spring`.
- Show a "beta" block only to requests carrying a custom HTTP header.
- Gate a block on a value stored in the user's session.
- Toggle a Context reaction based on a query parameter.
- Control Layout Builder section visibility by request data.
- Match a cookie exactly with the *must equal* operator.
- Exclude one value with *must not equal*.
- Show content only when a query parameter is set (any value) via *must be set*.
- Require a parameter to be set but empty via *must be set and have no value*.
- Require a header to be present and non-empty via *must be set and have any value*.
- Hide a block when a cookie is absent using *must not be set*.
- Match a header against a regular expression (no surrounding slashes).
- Show a block when a query value *contains* a substring.
- Hide a block when a cookie value *must not contain* a substring.
- Combine several rules with AND by leaving **Require all** checked.
- Combine several rules with OR by unchecking **Require all**.
- Match A/B-test bucketing carried in a cookie.
- Personalize a region based on a feature-flag query parameter.
- Detect a load balancer or CDN header and adjust visibility.
- Match a locale or currency cookie set by earlier code.
- Show a message when a `debug=1` query parameter is present.
- Vary a block for authenticated flows using a session flag.
- Add multiple named rules to one condition instance.
- Invert the whole condition with the condition system's standard "Negate" toggle.
- Build request-data-driven visibility without writing custom code.
