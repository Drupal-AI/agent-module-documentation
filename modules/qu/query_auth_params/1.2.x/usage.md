<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Query Auth Params lets you soft-protect individual pages by requiring a matching `?name=value` query parameter; requests without it are redirected to a configured URL or the front page.

---

Protected pages are configured at `/admin/config/development/query_auth_params` (permission `administer site configuration`). Each rule stores a relative URL, a query param name and value (both restricted to ≤10 alphanumeric characters), a display mode (`forever`, `once`, or until a `datetime_period`), and an optional redirect target. A `ControllerEvent` subscriber (`QueryAuthParamsSubscriber`) resolves the current path (and its alias, via the alias manager) against each rule; on a match it disables the page cache (kill switch) and compares the incoming query value with strict `===`. If the value matches, access proceeds; otherwise it returns a `TrustedRedirectResponse`. The `once` mode flips a `shown` flag in config after the first successful view so subsequent visits always redirect.

Operational/security notes: this is obscurity-based access control, not real authorization — the underlying route/entity permissions still apply, and the gate only redirects. The secret is carried in the URL query string, so it is exposed in browser history, `Referer` headers, proxy and web-server access logs; combined with the ≤10 alphanumeric limit this is a low-entropy, easily-logged shared secret. Use it for casual gating (soft launches, preview links), not for protecting sensitive content. Typical setup is adding one rule per page you want to gate.

---

- Require a query parameter to view a specific page.
- Protect a node path such as `/node/203` or its alias `/mathematics`.
- Redirect visitors without the parameter to the front page.
- Redirect to a custom URL instead of the front page.
- Share a preview link like `/page?access=secret123`.
- Gate a page permanently (`forever` mode).
- Allow a page to be viewed only once per configuration, then redirect.
- Open a page only until a chosen date/time (`datetime_period`).
- Configure multiple protected pages, each with its own parameter.
- Use both the system path and its alias interchangeably for a rule.
- Set a short alphanumeric parameter name (≤10 chars).
- Set a short alphanumeric parameter value (≤10 chars).
- Remove a protected-page rule from the settings form.
- Add another protected page via the AJAX add button.
- Bypass front-end page cache automatically on protected pages.
- Provide time-limited access to a campaign landing page.
- Hide a staging/preview page behind a shared link.
- Enforce a soft gate without creating user accounts.
- Validate that a protected path exists before saving.
- Prevent duplicate protected-path entries in configuration.
