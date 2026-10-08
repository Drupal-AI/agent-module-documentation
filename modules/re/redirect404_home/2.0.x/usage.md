Redirect 404 to Home Page overrides Drupal's `system.404` route so that requests for missing pages are answered with an HTTP redirect (configurable 301/302/303/307) plus an optional status message, instead of the normal "Page not found" page.

---

The module registers a `RouteSubscriber` that replaces the controller of core's `system.404` route with `Redirect404Home::on404()`. That controller reads `redirect404_home.settings` and returns a `RedirectResponse` whose HTTP status is the configured `redirection` code (301/302/303/307), optionally queueing a Messenger message (`status_message` with type `status`/`warning`/`error`). A single admin settings form at `admin/config/search/redirect404_home` (permission `administer site configuration`) exposes those three keys; there are no permissions or Drush commands of its own, and it depends on no other modules. Setup per the README is just to leave the site's *Default 404 (not found) page* (`system.site:page.404`) empty so core falls through to `system.404`, then clear caches. IMPORTANT — as shipped in 2.0.3 the controller redirects to `Url::fromRoute('system.404')`, i.e. the path `/system/404`, which the module has itself overridden; verified on Drupal 11 this yields an infinite 301 redirect **loop** to `/system/404` rather than a redirect to the front page. Treat the "redirects to the home page" description as the intended behavior, not the observed one, and see `agent/configure/settings.md` before relying on it. The module is tiny (one controller, one form, one route subscriber, a help hook) and provides a config schema for its three settings.

---

- Send all "page not found" (404) hits to a single destination instead of showing the 404 page.
- Return a 301 (permanent) redirect on 404s so search engines drop the missing URLs.
- Return a 302/303/307 (temporary) redirect on 404s while a site is being restructured.
- Show a flash message (e.g. "The page you requested was moved") when a 404 is redirected.
- Style that message as a status, warning, or error using Drupal's Messenger.
- Provide a catch-all landing experience for a brochure site with few real pages.
- Avoid exposing the default 404 page to anonymous visitors.
- Centralize 404 handling in one place rather than per-path redirect rules.
- Configure the redirect entirely from the UI at `admin/config/search/redirect404_home`.
- Pick the redirect method (301/302/303/307) to match caching/SEO needs.
- Replace a bespoke `hook_page_attachments`/exception subscriber with a drop-in module.
- Keep the redirect behavior in exportable config (`redirect404_home.settings`).
- Gate configuration behind the `administer site configuration` permission.
- Use it on small SEO-focused sites where every URL should resolve to something.
- Combine with the core Redirect module for known moves and this for the unknown remainder.
- Quickly demo/prototype a "no dead ends" navigation policy.
- Turn the redirect off simply by uninstalling the module (restores the core 404 route).
- Audit the intended vs. actual redirect target before production use (see the loop caveat).
- Adjust the message text without touching code via the settings form.
- Serve a friendlier code (e.g. 307) that preserves the request method on 404.
