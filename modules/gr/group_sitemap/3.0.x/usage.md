<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Sitemap generates an XML sitemap per group, filtered by anonymous view access.

---

Group Sitemap creates per-group XML sitemaps of group content, served at `/group/{group}/sitemap.xml` (with an XSL stylesheet). Each entry is included only if the relationship and target entity are viewable by the anonymous user, so restricted content is filtered out of the public sitemap.

The sitemap route is anonymous by design (`_access: 'TRUE'`); the access filtering on each entry (checking `access('view', $anonymous)`) is what prevents disclosure of restricted content — a per-entry safeguard rather than gating the endpoint. Depends on `group`; supports Drupal 10 and 11.

---

- Create per-group XML sitemaps.
- Serve at /group/{group}/sitemap.xml.
- Include an XSL stylesheet.
- List group content URLs.
- Filter entries by anonymous view access.
- Exclude restricted content.
- Serve the sitemap anonymously.
- Safeguard per entry, not per endpoint.
- Depend on `group`.
- Support Drupal 10 and 11.
- Help search engines index group content.
- Generate sitemap XML.
- Respect content visibility.
- Support group SEO.
- Filter by access('view', anonymous).
- Provide group sitemaps.
- Index public group content.
- Emit noindex on the file itself
