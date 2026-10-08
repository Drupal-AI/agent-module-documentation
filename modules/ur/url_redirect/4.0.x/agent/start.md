<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URL Redirect — agent index

Role/user-aware 301 redirects. Each rule is a **`url_redirect` config entity**
(`url_redirect.url_redirect.<id>`). A kernel REQUEST subscriber (priority 33) matches the
current path and, if the current user's role/identity matches, returns a 301
`TrustedRedirectResponse`. Managed at `/admin/config/system/url_redirect` (configure route
`entity.url_redirect.collection`). Depends on core `path`.

- **Create/read/update redirect rules (entity fields, drush, UI form)** →
  [configure/redirects.md](configure/redirects.md)
- **How matching & redirecting works (subscriber, wildcards, `<front>`, external, negate, 403)** →
  [api/mechanism.md](api/mechanism.md)
- **The three permissions the module defines** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entity keys: `path`, `redirect_path`, `redirect_for` (`Role`|`User`), `roles`, `users`,
  `negate` (bool), `message` (`Yes`|`No`), `status` (0|1). Config prefix `url_redirect`.
- `status` must be `1`/`Enabled` for a rule to fire; the subscriber only queries enabled rules.
- `path` matches the request URI (leading `/`, `<front>` for `/`, `*` wildcards). External
  `redirect_path` needs `http(s)://`; `<front>`/empty → front page; otherwise base-URL-prefixed.
