Anonymous Token extends Drupal core's CSRF token generation and validation so that CSRF tokens work for anonymous (not-logged-in) users, which core does not do out of the box.

---

By default Drupal only issues and validates CSRF tokens for authenticated users, because an anonymous session normally isn't persisted. This module ships a `AnonymousCsrfTokenGenerator` service that subclasses core's `CsrfTokenGenerator`; its `get()` forces a persistent session for anonymous users (writing a random `anon_session_id` when no session is started) so a per-session CSRF seed can be stored and later verified. It registers a route access checker (`access_check.anonymous_token.csrf`, tag `_anonymous_csrf_token`) that subclasses core's `CsrfAccessCheck` but uses the anonymous-aware generator. In the 2.x/3.x design nothing is wired up automatically: you opt in per route by adding `_anonymous_csrf_token: 'TRUE'` to a route's `requirements`, and you generate the matching token with the `anonymous_token.csrf_token` service. An optional `force_single_use` setting makes a token single-use by re-stamping the session metadata (`stampNew()`) after a successful validation, so a replayed token fails. The only permission is `administer anonymous csrf token`, gating the settings form at `/admin/config/system/anonymous-csrf-token`. It is a hardening/defensive module — the token is HMAC-derived from the site private key plus the session seed (core crypto), not a bypass or a grant of access.

---

- Protect an anonymous-facing custom route (e.g. a GET link that changes state) with a CSRF token requirement.
- Add CSRF protection to a route reachable by not-logged-in users where core's token would be unavailable.
- Generate a CSRF token for anonymous visitors to embed in a link or form via the `anonymous_token.csrf_token` service.
- Validate an incoming request's CSRF token for anonymous users using the module's access checker.
- Require single-use CSRF tokens so a token cannot be replayed after its first successful use.
- Harden a "confirm"/"unsubscribe"/"one-click" link that anonymous users follow against cross-site request forgery.
- Give an anonymous session enough persistence to carry a CSRF seed across requests.
- Reuse core's CSRF crypto (private key + session seed HMAC) for anonymous flows instead of rolling your own token.
- Add `_anonymous_csrf_token: 'TRUE'` to a route so its access check verifies the `?token=` query argument for anonymous users.
- Decorate an anonymous action link with `\Drupal::service('anonymous_token.csrf_token')->get($value)` to append a valid token.
- Enforce that GET-based state changes exposed to anonymous users carry a valid anti-CSRF token.
- Toggle single-use enforcement on or off from the admin settings form without code changes.
- Protect an anonymous webform/AJAX callback route that core leaves without a usable CSRF token.
- Provide anti-CSRF coverage for a decoupled/anonymous endpoint that issues a token then verifies it.
- Rotate the anonymous session's CSRF seed automatically after each validated single-use token.
- Restrict who can change the token behaviour with the `administer anonymous csrf token` permission.
- Keep the CSRF token behaviour identical to core for authenticated users while extending it to anonymous ones.
- Audit which routes rely on anonymous CSRF protection by searching for `_anonymous_csrf_token` requirements.
