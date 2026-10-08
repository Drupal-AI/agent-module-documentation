Redirect 403 to User Login (r4032login) catches 403 Access Denied responses and sends anonymous visitors to the login page instead, optionally returning them to the page they wanted after they log in.

---

The module registers a kernel exception subscriber (`R4032LoginSubscriber`, extending `HttpExceptionSubscriberBase`) that handles HTTP 403 exceptions for `html` requests. When an anonymous user hits an access-denied page, it issues a redirect to a configurable login path (default `/user/login`) and, if enabled, appends the original path as a `destination` query parameter so Drupal returns the user to that page after a successful login. It can display a configurable access-denied message (with a selectable message type: error, warning or status) on the login page. Behavior for already-authenticated users is separate: you can redirect them to a chosen page (including `<front>`), throw a 404 instead, and show them their own access-denied message. The redirect HTTP status code is configurable (307 Temporary Redirect by default, or 302/301), an optional `X-Robots-Tag: noindex` header can be added, and a path allow/deny list (`match_noredirect_pages`, with a negate toggle) lets you skip redirection for specific paths. All behavior is stored in the `r4032login.settings` config object (config schema provided) and edited across three tabbed forms under **Admin → Configuration → System → Redirect 403 to User Login**. Before redirecting, it dispatches a `RedirectEvent` (`r4032login.redirect`) so other modules can alter the target URL or options. The destination parameter name itself is overridable to integrate with external login systems such as CAS, Shibboleth or OAuth. It requires no modules outside Drupal core.

---

- Send anonymous users hitting a 403 straight to the login form instead of a bare access-denied page.
- Return users to the page they originally requested after they successfully log in.
- Show a friendly "Access denied. You must log in to view this page." message on the login page.
- Change the message type shown to anonymous users (error, warning, or status).
- Point the login redirect at a custom path instead of `/user/login` (e.g. a CAS or SSO login route).
- Redirect authenticated users who lack access to a specific landing page instead of showing 403.
- Send authenticated users to the front page (`<front>`) when they lack access.
- Throw a 404 Not Found to authenticated users instead of a 403 (hide the existence of the resource).
- Display a distinct access-denied message to authenticated users on their landing page.
- Set the redirect HTTP status code to 307 (default), 302, or 301.
- Add an `X-Robots-Tag: noindex` header so search engines don't index the redirect response.
- Skip the redirect for a list of paths (e.g. keep `/admin/*` on the standard 403).
- Negate the path list so the redirect happens only on listed paths.
- Override the destination query parameter name for external login systems (CAS, Shibboleth, OAuth).
- Redirect anonymous users to an external login URL and carry the original page as the destination.
- Alter the redirect URL or options at runtime by subscribing to the `r4032login.redirect` event.
- Preserve the incoming query string when returning an anonymous user to an external destination.
- Protect a members-only front page by redirecting anonymous visitors to login and back.
- Deploy the 403-redirect behavior as configuration (`r4032login.settings`) across environments.
- Gate who can configure the module via the `administer r4032login` permission.
- Provide a smoother, more user-friendly access experience than core's default access-denied page.
- Migrate legacy Drupal 7 r4032login settings via the bundled migration.
- Prevent redirect loops for authenticated users by stripping the destination on their redirect.
- Localize the access-denied messages through the config object's `langcode`.
