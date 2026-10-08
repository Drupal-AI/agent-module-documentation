<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Url Restrictions restricts default Drupal URLs such as node/*, taxonomy/* and user/* via a request subscriber that redirects users lacking a bypass permission.

---

Url Restrictions restricts access to Drupal's default entity URLs — patterns like `node/*`,
`taxonomy/*` and `user/*` — via a `KernelEvents::REQUEST` subscriber that redirects users who don't hold
the `allow_all_url` bypass permission away from those paths (to a configured destination). It is intended
to hide the raw system URLs behind clean paths or restrict direct access to entity canonical routes. It is
configured at `url_restrictions.config.form` and provides its own permissions.

Use it to steer users away from raw `node/123`-style URLs. Important scope caveat: this is a
**redirect-based** restriction at the request layer, **not entity access control** — it redirects the
matched paths, but the underlying content is not access-restricted, so it may still be reachable through
other routes (path aliases, JSON:API/REST, feeds, Views) that don't match the restricted patterns. Treat
it as URL-tidying/steering (or a soft deterrent), not as a confidentiality boundary; for real restriction
use entity/node access. Users with `allow_all_url` bypass it entirely.

---

- Restrict node/taxonomy/user URLs.
- Redirect users away from raw URLs.
- Hide default system paths.
- Bypass with allow_all_url permission.
- Enforce via a request subscriber.
- Configure at url_restrictions.config.form.
- Provide its own permissions.
- Steer users to clean paths.
- Understand it is redirect-based, not access control.
- Know content may be reachable via other routes.
- Not rely on it for confidentiality.
- Use entity access for real restriction.
- Treat as URL-tidying/steering.
- Redirect matched patterns.
- Apply a soft deterrent.
- Restrict canonical entity routes.
- Allow bypass for permitted users.
- Redirect to a destination.
- Hide raw entity URLs.
- Configure URL restrictions.
