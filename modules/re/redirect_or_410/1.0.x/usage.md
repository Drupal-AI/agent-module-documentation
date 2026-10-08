<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redirect or 410 lets redirects/404 handling return HTTP 410 Gone for removed content.

---

Redirect or 410 expands the Redirect and Redirect 404 module options so a path can return an HTTP 410 (Gone) response instead of a redirect or 404 — signalling to search engines that content is permanently removed, which helps SEO (410 is de-indexed faster than 404).

It's a redirect/SEO enhancement with no content or access role of its own. Depends on `redirect`; supports Drupal 10 and 11.

---

- Return 410 Gone for removed paths.
- Expand Redirect/Redirect 404 options.
- Signal permanent removal.
- Improve SEO for gone content.
- De-index faster than 404.
- Choose 410 vs redirect/404.
- Depend on `redirect`.
- Support Drupal 10 and 11.
- Carry no content/access role.
- Handle removed content.
- Support SEO hygiene.
- Configure 410 responses.
- Manage gone URLs
- Enhance Redirect
- Return proper status codes.
- Support search engines.
- Handle deletions.
- Serve 410
