<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookie SameSite support sets `SameSite=None` on Drupal's session cookie and emits a legacy duplicate without the attribute, so sessions survive in cross-site contexts across browsers old and new.

---

`SameSite` controls whether a cookie is sent on requests originating from another site, and browsers now default it to `Lax`, which is a deliberate anti-CSRF measure. That default breaks one legitimate pattern: a Drupal site **embedded in an iframe on another domain** — an authenticated widget, a booking module inside a partner's page, an app inside a portal — where the session cookie is simply not sent and the user appears logged out. The fix is `SameSite=None`, and the complication is that some older browsers reject the value outright rather than ignoring it, dropping the cookie entirely. The published workaround is to send **two cookies**: a modern one with `SameSite=None; Secure` and a legacy duplicate without the attribute. That is what this module implements, decorating `SessionManager` and `SessionConfiguration`, citing web.dev's SameSite cookie recipes in its own source. Version **1.1.1** on `^9 || ^10 || ^11`. Install it knowing exactly what is being given up. **`SameSite` is a CSRF defence**, and `None` switches it off for the session cookie — Drupal's own form tokens and `_csrf_token` route requirements remain, and they are the primary defence, but a layer has been removed, so any route that changes state without a token becomes materially more exposed. **`Secure` is mandatory** with `None`, so the site must be HTTPS throughout. And the legacy duplicate is a second copy of a session identifier travelling on every request, which is worth confirming is still needed for the browsers the site actually serves.

---

- Embed an authenticated site in an iframe.
- Keep sessions working cross-site.
- Support a widget on a partner domain.
- Fix "logged out inside the iframe".
- Support an embedded booking flow.
- Serve a portal-hosted application.
- Support older browsers rejecting SameSite=None.
- Keep a payment flow's session.
- Support a cross-domain SSO return.
- Fix cookies dropped after a browser update.
- Support an embedded intranet tool.
- Keep an authenticated map widget working.
- Support a marketing iframe integration.
- Serve an app inside a customer's site.
- Diagnose cross-site session loss.
- Support a legacy browser estate.
- Keep a cross-origin dashboard signed in.
- Meet an embedding requirement.
