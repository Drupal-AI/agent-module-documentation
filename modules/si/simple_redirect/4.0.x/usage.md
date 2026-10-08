<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Redirect applies admin-configured 301 redirects from one internal path to another.

---

Simple Redirect provides a `simple_redirect` config entity (managed at `/admin/config/search/simple-redirect`, `administer site configuration` permission) storing a from-path and to-path. A `kernel.request` event subscriber compares the incoming request URI against each configured `from` and, on an exact match, issues a 301 `RedirectResponse` to the `to` path (resolved with `Url::fromUserInput`). The edit form validates that paths start with `/`, forbids redirecting from `<front>` or with anchors, and prevents duplicates. Because targets are admin-configured internal paths, there is no user-controlled/open redirect. Core-only; no custom permissions.

---

- Redirect one internal path to another.
- Issue permanent 301 redirects.
- Define redirects as config entities.
- Manage redirects in an admin list.
- Add/edit/delete redirects via forms.
- Match the incoming request URI exactly.
- Resolve targets as internal paths.
- Validate that paths start with a slash.
- Prevent redirecting from the front page.
- Reject anchor fragments in the source path.
- Prevent duplicate source paths.
- Apply redirects early on kernel.request.
- Restrict management to site config admins.
- Work on Drupal 8.9 through 10.
- Avoid the full Redirect module.
- Handle simple path-migration redirects.
