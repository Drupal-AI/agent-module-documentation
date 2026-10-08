<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Route access checks based on configurable HTTP-header profiles.

---

Routing Access Check Headers provides route access checks based on configurable HTTP header profiles — a `_routing_access_check_headers` route requirement that matches request headers against a named profile plugin (e.g. XHR via `X-Requested-With`, or iframe via `Sec-Fetch-Dest`), used as defense-in-depth to restrict routes to a request shape.

It is **fail-closed**: a missing/unknown profile returns forbidden (modeled on core's `CsrfRequestHeaderAccessCheck`). It is a request-shape filter, not an authentication mechanism. Supports Drupal 11.

---

- Check access by HTTP headers.
- Use configurable header profiles.
- Match XHR/iframe request shapes.
- Add a route requirement.
- Fail closed on missing profiles.
- Serve as defense-in-depth.
- Support Drupal 11.
- Configure profiles.
- Not replace authentication.
- Handle header access checks.
- Filter by request shape.
- Restrict routes
- Support Drupal.
- Support Drupal.
- Support Drupal.
