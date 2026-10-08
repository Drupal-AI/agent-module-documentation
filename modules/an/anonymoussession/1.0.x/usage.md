<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Anonymous session toolkit provides a service that ensures a real session exists for anonymous visitors, so custom code can reliably read and write per-visitor session data.

---

The module ships a single service (`anonymoussession`, class `AnonymousSessionService`) with one public method, `apply()`. Calling it on an anonymous request writes a marker into `$_SESSION` and starts Drupal's core `SessionManager`, guaranteeing that subsequent code sees a persistent session for that visitor. This is a developer building block, not an end-user feature: there is no UI, no routes, no permissions, and no configuration. It exists because, by default, Drupal is reluctant to establish a session (and a session cookie) for anonymous users, which makes anonymous `PrivateTempStore`, `$_SESSION` writes, and anything relying on `Drupal::currentRequest()->getSession()` unreliable. Session creation, IDs, and cookies are all handled by core; the module only decides *when* to force a session to start. Note the operational trade-off: an anonymous user with a session is not served Drupal's anonymous page cache, so `apply()` should be called only on the specific paths/requests where anonymous state is actually needed.

---

- Force a session to exist for an anonymous visitor before writing `$_SESSION`.
- Back an anonymous `PrivateTempStore` (multi-step forms/wizards for logged-out users).
- Persist a logged-out shopping cart or basket keyed to the session.
- Keep anonymous quiz/survey progress across page loads.
- Store anonymous UI preferences (dismissed banners, chosen tab) per visitor.
- Make `Drupal::currentRequest()->getSession()` return a usable session for anonymous code paths.
- Give anonymous "save for later"/wishlist features a place to persist.
- Hold a pre-registration onboarding wizard's state before an account exists.
- Track an anonymous checkout flow's intermediate data.
- Retain form values across a multi-request anonymous flow.
- Provide session-scoped tokens/flags for custom anonymous features.
- Ensure consistent session behaviour between authenticated and anonymous code branches.
- Establish a session early in a request so later services can rely on it.
- Support anonymous personalization that must survive navigation.
- Remember an anonymous visitor's locale/currency selection for a flow.
- Gate a one-time interstitial ("seen it") per anonymous session.
- Persist filter/sort choices for an anonymous browsing session.
- Enable custom modules to depend on `anonymoussession` and call `apply()` where needed.
- Add the service as a constructor dependency in your own service and invoke `apply()` on demand.
- Scope session creation to only the routes/paths that require anonymous state, to limit cache impact.
