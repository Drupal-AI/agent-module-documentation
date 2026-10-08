# Configuration

Admin UI Only has a small settings form with two things to decide: which routes
stay reachable on the front end, and what response a blocked request receives.
Getting the allow-list right is the whole job — everything not admin and not
allowed will be blocked.

## Allowed routes (the whitelist)

By default the module permits Drupal's **admin routes** through. Any other
front-end route is denied unless you add it to the allowed-routes list. Use this
list to name every route that must remain publicly reachable on a decoupled site,
for example:

- Your API entry points — **JSON:API** and/or **GraphQL** routes that your
  front-end application calls.
- The **login** page (and, if you rely on them, password reset and other
  authentication paths), so administrators can still sign in.
- Any other endpoint a client, webhook, or health-check depends on.

Work through this carefully. A route you forget to add will be blocked, which can
silently break the front-end app or lock you out; conversely, double-check that
you have not left anything sensitive reachable that should be closed. Test the
allow-list on a non-production environment before relying on it.

## Denial response code

Choose what a blocked request returns:

- **403 (Forbidden)** — states plainly that access is denied.
- **404 (Not Found)** — hides the fact that a page exists at all, which some
  operators prefer for a headless backend so the front end reveals nothing about
  Drupal's routes.

Pick whichever matches how much you want to disclose about the backend.

## Save and verify

Save the form, then verify the result: as an anonymous visitor, request a normal
front-end page and confirm you get your chosen 403 or 404, then request your API
endpoints and the login page and confirm they still respond. Remember this module
**complements** per-route access control — each API endpoint still needs its own
access rules; Admin UI Only only narrows what is reachable at all.
