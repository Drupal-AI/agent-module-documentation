Force site-wide login by redirecting every anonymous request to Drupal's `/user/login` page.

---

Anonymous Redirection is a zero-configuration "force login" module. It registers a single kernel `REQUEST` event subscriber (`AnonymousRedirectionSubscriber`) that runs early in the request and, for any anonymous user, issues a `302` redirect to the fixed internal path `/user/login`. To avoid a redirect loop the subscriber lets three core routes through untouched: `user.login`, `user.register` and `user.pass` (login, register and password-reset). There is no settings form, no configuration object, no permission and no route defined by the module — enabling it turns the whole site into a members-only site. Because the gate is a blanket check on every route, it also intercepts anonymous access to the front page, REST/JSON:API endpoints, image-style derivatives, AJAX system paths and any other anonymous-facing route, so it is best suited to fully private sites, staging/pre-launch lockdowns and intranets rather than sites with a public front end.

---

- Lock a whole staging or pre-launch site behind login without touching per-page permissions.
- Turn a Drupal install into a members-only / intranet site where anonymous users see only the login form.
- Enforce authentication on a site holding sensitive or user-specific content.
- Redirect visitors who hit an admin path while logged out straight to the login screen.
- Provide a quick "coming soon" gate that still lets people register and reset their password.
- Guide anonymous users to authenticate instead of returning a bare `403 Access denied`.
- Keep an internal tool or dashboard reachable only after login.
- Hide all content types, views and taxonomy listings from anonymous crawlers.
- Prevent anonymous browsing of node pages on a subscription/paywalled site.
- Enable during a maintenance window so only editors can reach the site.
- Combine with a client-facing extranet where every page requires a session.
- Restrict a documentation site to authenticated employees only.
- Stop anonymous form submissions by forcing login before any page loads.
- Route logged-out users of a SaaS-style Drupal app to the sign-in page automatically.
- Add a global login wall on top of core without writing a custom event subscriber.
- Ensure password-reset and self-registration flows still work while everything else is gated.
- Keep an event or membership portal private until visitors authenticate.
- Quickly demonstrate a login-required experience for a client review.
- Guard a multi-site child install that should never expose content anonymously.
- Use as a lightweight alternative to more configurable "restrict access" modules when a single fixed rule is all that is needed.
